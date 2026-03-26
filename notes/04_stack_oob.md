# [04] stack_oob

## 1. 개요
- Bug Type: stack-buffer-overflow
- CWE: CWE-121
- Category: basic

## 2. 코드 설명
- `main`의 지역 배열 `int arr[4]` 선언
- 정상 범위는 `arr[0] ~ arr[3]`
- `arr[4] = 100`에서 stack 오른쪽 경계 밖 4바이트 write 발생

## 3. 실행
- build/run 완료
- ASan이 `stack-buffer-overflow`를 보고하고 abort

## 4. 결과
- 오류 위치: `stack_oob.c:14:12`
- 오류 유형: `WRITE of size 4`
- 문제 주소: `0x7641b2000030`
- `main` 프레임 내 `arr`의 끝(offset 48) 바로 바깥 접근

## 5. 핵심 로그
- `AddressSanitizer: stack-buffer-overflow`
- `This frame has 1 object(s): [32, 48) 'arr'`
- `Memory access at offset 48 overflows this variable`
- shadow bytes: `f1 f1 f1 f1 00 00 [f3] f3 ...`

## 6. 왜 잡혔는가
- `arr`는 16바이트 크기의 스택 배열이다.
- 프레임 내에서 `arr`의 범위는 `[32, 48)`로 배치된다.
- `arr[4]`는 시작점에서 16바이트 뒤이므로 offset 48에 해당한다.
- 이 위치는 `arr`의 유효 범위를 벗어난 직후 영역이다.
- 이번 케이스는 stack right redzone 침범이다.
- shadow byte에서 redzone 상태(`f3`)가 확인되며, store 전 검사에서 탐지된다.

## 7. IR 분석
- `main`에 `sanitize_address` 적용
- ASan이 일반 지역 배열 대신 확장된 stack frame을 구성
- `arr` 주변에 stack redzone을 배치하는 흐름 확인
- `arr[4] = 100` 앞에서 shadow 검사 후 `__asan_report_store4` 호출 경로 확인
- 이후 코드가 있더라도 실제 실행은 store에서 먼저 중단됨

## 8. ASM 분석
- `main` 기준 디스어셈블 확인
- ASan local stack 영역을 더 크게 확보한 뒤 `arr`를 그 내부 오프셋에 배치
- shadow address 계산(`addr >> 3` + shadow base) 흐름 확인
- 문제 구간에서 store 전 검사 분기와 `__asan_report_store4` 호출 흐름 존재
- 이후 `arr[4]` read에 대해 `__asan_report_load4` 경로도 별도로 존재

## 9. 핵심 개념
- stack-buffer-overflow
- stack right redzone
- shadow memory
- `__asan_report_store4`

## 10. 결론
- 이번 예제는 스택 지역 배열의 오른쪽 경계 밖 write를 재현한 기본 사례이다.
- ASan은 스택 객체 주변에도 redzone을 배치하고, shadow memory 기반 접근 전 검사로 이를 탐지한다.

## 11. 확장
- `heap_oob`와 비교
- 왼쪽 경계 접근으로 stack underflow성 변형 실험
- 지역변수를 여러 개 둘 때 redzone 배치 변화 비교