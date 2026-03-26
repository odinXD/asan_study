# [02] heap_oob

## 1. 개요
- Bug Type: heap-buffer-overflow
- CWE: CWE-122
- Category: basic

## 2. 코드 설명
- `malloc(16)`으로 int 4개 공간 할당
- 정상 범위는 `arr[0] ~ arr[3]`
- `arr[4] = 100`에서 heap 오른쪽 경계 밖 4바이트 write 발생

## 3. 실행
- build/run 완료
- ASan이 `heap-buffer-overflow`를 보고하고 abort

## 4. 결과
- 오류 위치: `heap_oob.c:21:12`
- 오류 유형: `WRITE of size 4`
- 문제 주소: `0x502000000020`
- `0 bytes after 16-byte region`

## 5. 핵심 로그
- `AddressSanitizer: heap-buffer-overflow`
- `0x502000000020 is located 0 bytes after 16-byte region`
- shadow bytes: `fa fa 00 00 [fa] fa ...`

## 6. 왜 잡혔는가
- `arr[4]`는 할당된 16바이트 바로 다음 주소를 가리킨다.
- 이번 케이스는 heap right redzone 침범이다.
- shadow byte에서 redzone 상태(`fa`)가 확인되며, store 전 검사에서 탐지된다.

## 7. IR 분석
- `main`에 `sanitize_address` 적용
- `malloc(16)` 호출 확인
- `arr[4] = 100` 앞에서 shadow 검사 후 `__asan_report_store4` 호출 경로 확인
- 다음 줄 `arr[4]` read도 `__asan_report_load4` 대상이지만, 실제 실행은 store에서 먼저 중단됨

## 8. ASM 분석
- `main` 기준 gdb 디스어셈블 확인
- 문제 구간에서 store 전 검사 분기와 report 호출 흐름 존재

## 9. 핵심 개념
- heap-buffer-overflow
- heap right redzone
- `__asan_report_store4`

## 10. 결론
- 이번 예제는 heap 버퍼 오른쪽 경계 밖 write를 재현한 기본 사례이다.
- ASan은 redzone 상태를 shadow memory에 반영하고, 접근 전 검사로 이를 탐지한다.

## 11. 확장
- `heap_underflow`와 비교
- `arr[5]`, `arr[-1]` 변형 실험