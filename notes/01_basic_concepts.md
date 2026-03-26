# [01] basic_concepts

## 1. 개요
- ASan(AddressSanitizer)은 메모리 오류 탐지를 위한 sanitizer이다.
- 핵심 구성은 compiler instrumentation, shadow memory, redzone, runtime report이다.

## 2. ASan이 잘 잡는 대표 오류
- heap-buffer-overflow
- stack-buffer-overflow
- global-buffer-overflow
- use-after-free
- use-after-scope

## 3. 핵심 원리
### redzone
- 유효한 메모리 영역 주변에 배치되는 보호 구역
- 경계 밖 접근을 탐지하기 위해 poisoned 상태로 관리됨

### shadow memory
- 실제 메모리의 접근 가능 여부를 저장하는 메타데이터
- 보통 실제 메모리 8바이트당 shadow 1바이트를 사용

### compiler instrumentation
- load/store 전에 shadow 검사 코드를 삽입
- 잘못된 접근이면 `__asan_report_*` 호출

### runtime report
- 오류 종류, 접근 크기, 문제 주소, allocation stack trace, shadow bytes 등을 출력

## 4. 자주 보게 되는 shadow byte
- `00`: addressable
- `01~07`: partially addressable
- `fa`: heap redzone
- `fd`: freed heap region
- `f1/f2/f3`: stack redzone
- `f9`: global redzone

## 5. 로그 읽기 포인트
- `WRITE of size N` / `READ of size N`
- `X bytes after/before N-byte region`
- allocation stack trace
- shadow bytes around the buggy address

## 6. IR/ASM에서 볼 것
### IR
- `sanitize_address`
- `__asan_report_store4`, `__asan_report_load4`
- shadow address 계산 패턴

### ASM
- `main` 기준 문제 구간
- store/load 전 검사 분기
- report 호출 존재 여부

## 7. 한계
- ASan은 poisoned memory 기반 탐지기이므로 모든 논리 오류를 잡지는 못한다.
- 일부 intra-object overflow, partial instrumentation, allocator 특수 케이스 등은 놓칠 수 있다.

## 8. 정리
- ASan의 본질은 “redzone + shadow memory + compiler instrumentation + runtime report”이다.
- 이후 실험 노트에서는 각 오류 사례를 이 관점으로 해석한다.