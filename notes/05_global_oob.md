# [05] global_oob

## 1. 개요
- Bug Type: global-buffer-overflow
- CWE: CWE-787
- Category: basic

## 2. 코드 설명
- 전역 배열 `int global_buffer[4]` 선언
- 정상 범위는 `global_buffer[0] ~ global_buffer[3]`
- `global_buffer[4] = 999`에서 global 오른쪽 경계 밖 4바이트 write 발생

## 3. 실행
- build/run 완료
- ASan이 `global-buffer-overflow`를 보고하고 abort

## 4. 결과
- 오류 위치: `global_oob.c:17:22`
- 오류 유형: `WRITE of size 4`
- 문제 주소: `0x63198c80cb50`
- `global_buffer` 끝 바로 다음 주소(`0 bytes after global variable`) 접근

## 5. 핵심 로그
- `AddressSanitizer: global-buffer-overflow`
- `0x63198c80cb50 is located 0 bytes after global variable 'global_buffer'`
- `global variable 'global_buffer' ... of size 16`
- shadow bytes: `00 00 [f9] f9 ...`

## 6. 왜 잡혔는가
- `global_buffer`는 16바이트 크기의 전역 배열이다.
- `global_buffer[4]`는 시작점에서 16바이트 뒤이므로 배열 끝 바로 다음 주소에 해당한다.
- 이 위치는 전역 배열의 유효 범위를 벗어난 직후 영역이다.
- 이번 케이스는 global right redzone 침범이다.
- shadow byte에서 global redzone 상태(`f9`)가 확인되며, store 전 검사에서 탐지된다.

## 7. IR 분석
- `global_buffer`는 단순 `[4 x i32]` 전역 배열이 아니라, ASan 적용 후 `{ [4 x i32], [16 x i8] }` 형태로 재작성된다.
- 앞의 `[4 x i32]`는 실제 데이터 16바이트이고, 뒤의 `[16 x i8]`는 right global redzone이다.
- `arr[4] = 100`과 유사하게, `global_buffer[4] = 999` 앞에서 shadow 검사 후 `__asan_report_store4` 호출 경로가 삽입된다.
- 검사 흐름은 접근 주소 계산 → `addr >> 3` → shadow base 더하기 → shadow byte load → 위반 시 report 호출 순서로 진행된다.
- 이후 코드가 있더라도 실제 실행은 store에서 먼저 중단된다.

## 8. ASM 분석
- `main` 기준 디스어셈블 확인
- `lea ... <global_buffer>` 후 `add $0x10`으로 `global_buffer + 16` 주소를 계산한다.
- shadow address 계산(`addr >> 3` + shadow base) 흐름 확인
- 문제 구간에서 store 전 검사 분기와 `__asan_report_store4` 호출 흐름 존재
- 실제 문제 store는 `movl $0x3e7, ... <global_buffer+16>`로 나타난다.

## 9. 핵심 개념
- global-buffer-overflow
- global right redzone
- shadow memory
- `__asan_report_store4`

## 10. 결론
- 이번 예제는 전역 배열의 오른쪽 경계 밖 write를 재현한 기본 사례이다.
- ASan은 전역 객체 주변에도 redzone을 두고, shadow memory 기반 접근 전 검사로 이를 탐지한다.

## 11. 확장
- `stack_oob`와 비교
- 전역 배열 왼쪽 경계 접근 실험
- 전역 변수를 여러 개 둘 때 배치와 redzone 변화 비교