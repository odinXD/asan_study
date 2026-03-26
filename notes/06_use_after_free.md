# [06] use_after_free

## 1. 개요
- Bug Type: heap-use-after-free
- CWE: CWE-416
- Category: basic

## 2. 코드 설명
- `malloc(16)`으로 int 4개 공간 할당
- 정상 범위는 `buffer[0] ~ buffer[3]`
- 값을 초기화한 뒤 `free(buffer)`로 heap 영역 해제
- 이후 `buffer[1] = 999`에서 해제된 heap 영역에 write 발생

## 3. 실행
- build/run 완료
- ASan이 `heap-use-after-free`를 보고하고 abort

## 4. 결과
- 오류 위치: `use_after_free.c:25:15`
- 오류 유형: `WRITE of size 4`
- 문제 주소: `0x502000000014`
- `16-byte region [0x502000000010, 0x502000000020)` 내부의 `4 bytes inside` 위치 접근

## 5. 핵심 로그
- `AddressSanitizer: heap-use-after-free`
- `0x502000000014 is located 4 bytes inside of 16-byte region [0x502000000010,0x502000000020)`
- `freed by thread T0 here: use_after_free.c:23:5`
- `previously allocated by thread T0 here: use_after_free.c:11:26`
- shadow bytes: `fa fa [fd] fd fa fa ...`

## 6. 왜 잡혔는가
- `buffer`는 원래 16바이트 heap 영역을 가리키고 있었다.
- `buffer[1]` 자체는 원래 할당 범위 내부 주소이므로, free 이전에는 정상 접근이다.
- 하지만 `free(buffer)` 이후 해당 유저 영역은 더 이상 유효하지 않다.
- ASan은 해제된 heap 영역의 shadow byte를 freed region 상태(`fd`)로 poison한다.
- 이후 `buffer[1] = 999` store 직전 shadow 검사에서 해당 주소가 `fd` 상태임이 확인되어 탐지된다.
- 이번 케이스는 redzone 침범이 아니라, **해제된 heap 영역 자체에 대한 접근(use-after-free)** 검출이다.

## 7. IR 분석
- `buffer[1] = 999` 앞에 ASan shadow 검사 코드가 삽입된다.
- 접근 주소를 `ptrtoint`로 정수화한 뒤, `(addr >> 3) + 0x7fff8000` 형태로 shadow 주소를 계산한다.
- shadow byte를 읽고, 값이 0이면 정상 store 경로로 진행한다.
- 0이 아니면 slow path 비교를 수행하고, 위반 시 `__asan_report_store4` 호출 경로로 분기한다.
- 이번 케이스에서는 free 이후 해당 영역의 shadow가 freed region(`fd`) 상태이므로 report 호출로 이어진다.
- 실제 `store i32 999`보다 shadow 검사가 먼저 수행되며, 실행은 그 지점에서 중단된다.

## 8. ASM 분석
- `main` 기준 디스어셈블 확인
- `buffer` 주소를 불러온 뒤 `add $0x4`로 `buffer[1]` 주소를 계산한다.
- 이후 `shr $0x3` 및 shadow base 참조를 통해 shadow byte를 읽는다.
- `cmp $0x0, %al`로 fast path 여부를 확인하고, 필요 시 추가 slow path 비교를 수행한다.
- 위반 시 `__asan_report_store4` 호출 흐름으로 이어진다.
- 실제 문제 store는 `movl $0x3e7, (%rax)` 형태로 나타나지만, 실행 중에는 report가 먼저 발생한다.

## 9. 핵심 개념
- heap-use-after-free
- dangling pointer
- freed heap region
- shadow memory
- `__asan_report_store4`

## 10. 결론
- 이번 예제는 heap 메모리를 해제한 뒤 다시 접근하는 use-after-free의 기본 사례이다.
- ASan은 해제된 heap 영역을 shadow memory에서 `fd`로 표시하고, 접근 전 검사로 이를 탐지한다.
- 즉, 이번 검출의 본질은 경계 위반이 아니라 **lifetime 위반**이다.

## 11. 확장
- `heap_oob`와 비교
- free 후 read 예제 추가
- `buffer = NULL` 처리 유무 비교
- quarantine 동작과 freed region 유지 시간 관찰