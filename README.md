# 📌 ASan Study Project Guideline

---

# 1. 프로젝트 목적

본 프로젝트는 단순 ASan 사용이 아니라 다음을 목표로 한다.

## 목표
- 메모리 오류 직접 재현
- ASan 탐지 원리 이해
- LLVM 내부 구현 분석
- IR / ASM 수준까지 연결
- ASan이 못 잡는 케이스까지 분석

---

# 2. 전체 시스템 구조


[코드 실행층] → asan-study (Git)
[지식 저장층] → notes (Markdown)
[분석 보조층] → ChatGPT
[자동화 계층] → scripts (build/run/IR/ASM)


---

# 3. 디렉터리 구조


asan-study/
├─ src/
│ ├─ basic/
│ ├─ advanced/
│ └─ playground/
│
├─ bin/
├─ logs/
├─ ir/
├─ asm/
│
├─ notes/
│ ├─ roadmap.md
│ ├─ progress.md
│ ├─ index.md
│ │
│ ├─ basic/
│ ├─ advanced/
│ └─ llvm/
│
├─ scripts/
├─ README.md
├─ build.sh
├─ run.sh
└─ clean.sh


---

# 4. 핵심 운영 원칙

## 원칙 1: 테스트 하나 = 완전한 1세트


src/basic/heap_oob.c
bin/basic/heap_oob
logs/basic/heap_oob.log
ir/basic/heap_oob.ll
asm/basic/heap_oob.txt
notes/basic/02_heap_oob.md


---

## 원칙 2: 모든 실험은 반드시 기록

- 로그 없이 넘어가지 않는다
- IR 없이 넘어가지 않는다
- "왜 잡혔는지" 반드시 기록한다

---

## 원칙 3: ChatGPT는 분석 엔진

- 기록은 반드시 notes에 저장
- ChatGPT는 notes 기반으로 분석

---

# 5. 파일 네이밍 규칙

## 코드 파일

heap_oob.c
heap_underflow.c
stack_oob.c


- 번호 없음
- 의미 중심

---

## 노트 파일

02_heap_oob.md
03_heap_underflow.md


- 번호 포함
- 학습 순서 유지

---

## 코드 상단 주석 (필수)

// Study ID: 02
// Category: basic
// Test Name: heap_oob
// Bug Type: heap-buffer-overflow

# 6. 작업 흐름
## 1. 코드 작성
## 2. build
## 3. run (로그 생성)
## 4. IR 생성
## 5. ASM 생성
## 6. notes 작성
## 7. git commit
## 8. ChatGPT 분석
## 9. notes 업데이트

# 7. 스크립트 사용
build
./build.sh basic heap_oob
run
./run.sh basic heap_oob
IR 생성
./scripts/emit_ir.sh basic heap_oob
ASM 생성
./scripts/dump_asm.sh basic heap_oob

# 8. notes 작성 템플릿
# [02] heap_oob

## 1. 개요
- Bug Type:
- CWE:
- Category:

## 2. 코드 설명

## 3. 실행

## 4. 결과

## 5. 핵심 로그

## 6. 왜 잡혔는가
- redzone 관점
- shadow memory 관점

## 7. IR 분석

## 8. ASM 분석

## 9. 핵심 개념

## 10. 결론

## 11. 확장

# 9. 학습 로드맵

## Phase 1: Basic
heap OOB
heap underflow
stack OOB
global OOB
use-after-free
leak

## Phase 2: Advanced
use-after-return
use-after-scope
intra-object overflow
nonlinear cases
## Phase 3: LLVM Internals
AddressSanitizer.cpp
instrumentAddress
createSlowPathCmp
getRedzoneSizeForGlobal
__asan_report 삽입 구조
## Phase 4: Limitations
ASan miss cases
intra-object overflow
allocator edge cases
partial instrumentation

# 10. Git 운영 전략
기본 커밋
git add .
git commit -m "02 heap_oob 분석 완료"
커밋 기준
코드 + 로그 + notes 완료 단위
IR 분석 추가
ASM 분석 추가

# 11. ChatGPT 사용 규칙
❌ 금지
기록 없이 질문만 반복
✅ 권장
이건 heap_oob notes인데,
IR 분석 이어서 해줘
핵심

항상 notes 기반으로 질문

# 12. 컨텍스트 유지 전략
반드시 수행
모든 분석은 notes에 저장
대화 내용은 필요한 것만 정리
다음 세션 시작 시 상태 공유
시작 템플릿
현재 상태:
- heap_oob 완료
- 로그/IR/ASM 확보
- notes 작성 완료

다음 목표:
- IR 분석 진행

# 13. 자동화 확장 계획
makefile 도입
analyze.sh (전체 자동화)
로그 timestamp 자동 저장
테스트 자동 실행

# 14. 핵심 개념
ASan 본질
shadow memory + redzone + compiler instrumentation + runtime report
ASan 한계
poisoned memory 기반 탐지 → 논리적 오류 100% 탐지 불가

# 15. 최종 결론

본 프로젝트는 단순 실습이 아니라

메모리 오류 분석 + 컴파일러 내부 이해 + 보안 연구

를 목표로 한다.