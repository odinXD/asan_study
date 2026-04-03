# ASan Study Project Guideline

AddressSanitizer를 단순히 실행해보는 수준을 넘어서,  
메모리 오류를 직접 재현하고, 탐지 원리와 LLVM 내부 동작까지 연결해서 분석하는 학습 프로젝트의 운영 기준 문서입니다.

---

## 1. 프로젝트 목적

이 프로젝트의 목표는 다음과 같습니다.

- 메모리 오류 직접 재현
- ASan 탐지 원리 이해
- LLVM 내부 구현 분석
- IR / ASM 수준까지 연결
- ASan이 놓치는 한계 사례 분석

즉, 단순 실습이 아니라  
**메모리 오류 분석 + 컴파일러 내부 이해 + 보안 연구**를 함께 수행하는 것을 목표로 합니다.

---

## 2. 전체 시스템 구조

```text
[코드 실행층]      → asan-study (Git)
[지식 저장층]      → notes (Markdown)
[분석 보조층]      → ChatGPT
[자동화 계층]      → scripts (build/run/IR/ASM)
```

---

## 3. 디렉터리 구조

```text
asan-study/
├─ src/
│  ├─ basic/
│  ├─ advanced/
│  └─ playground/
│
├─ bin/
├─ logs/
├─ ir/
├─ asm/
│
├─ notes/
│  ├─ roadmap.md
│  ├─ progress.md
│  ├─ index.md
│  ├─ basic/
│  ├─ advanced/
│  └─ llvm/
│
├─ scripts/
├─ README.md
├─ GUIDELINE.md
├─ build.sh
├─ run.sh
└─ clean.sh
```

---

## 4. 핵심 운영 원칙

### 원칙 1. 테스트 하나 = 완전한 1세트입니다

하나의 실험은 반드시 아래처럼 대응되는 파일 세트를 갖춰야 합니다.

```text
src/basic/heap_oob.c
bin/basic/heap_oob
logs/basic/heap_oob.log
ir/basic/heap_oob.ll
asm/basic/heap_oob.txt
notes/basic/02_heap_oob.md
```

즉, **코드만 있고 로그가 없거나**,  
**로그는 있는데 notes가 없는 상태로 끝내지 않습니다.**

---

### 원칙 2. 모든 실험은 반드시 기록합니다

각 실험마다 최소한 아래 항목은 남깁니다.

- 실행 로그
- LLVM IR
- ASM 또는 핵심 디스어셈블 결과
- 왜 ASan이 이 오류를 잡았는지에 대한 설명

핵심은 단순히 “에러가 났다”가 아니라  
**왜 탐지되었는가를 구조적으로 설명할 수 있어야 한다**는 점입니다.

---

### 원칙 3. ChatGPT는 분석 엔진입니다

- 기록은 항상 `notes/`에 저장합니다.
- ChatGPT는 기록을 대신 보관하는 저장소가 아닙니다.
- ChatGPT는 `notes`를 바탕으로 분석을 확장하는 역할을 합니다.

즉, 실험 결과와 해석의 최종 저장 위치는 항상 **Markdown notes**입니다.

---

## 5. 파일 네이밍 규칙

### 코드 파일

코드 파일은 번호 없이, 의미 중심으로 작성합니다.

예시는 다음과 같습니다.

```text
heap_oob.c
heap_underflow.c
stack_oob.c
global_oob.c
use_after_free.c
```

---

### 노트 파일

노트 파일은 번호를 포함하여 학습 순서를 유지합니다.

예시는 다음과 같습니다.

```text
02_heap_oob.md
03_heap_underflow.md
04_stack_oob.md
05_global_oob.md
06_use_after_free.md
```

---

### 코드 상단 주석 규칙

모든 테스트 코드는 상단에 다음 메타데이터를 포함합니다.

```c
// Study ID: 02
// Category: basic
// Test Name: heap_oob
// Bug Type: heap-buffer-overflow
```

이 정보는 나중에 notes, logs, commit history와 대응시키기 쉽게 해줍니다.

---

## 6. 작업 흐름

모든 테스트는 반드시 아래 순서로 진행합니다.

1. 코드 작성
2. build
3. run (로그 생성)
4. IR 생성
5. ASM 생성
6. notes 작성
7. git commit
8. ChatGPT 분석
9. notes 업데이트

핵심은 **실행 → 관찰 → 기록 → 분석 → 보강** 흐름을 고정하는 것입니다.

---

## 7. 스크립트 사용 규칙

### Build

```bash
./build.sh basic heap_oob
```

### Run

```bash
./run.sh basic heap_oob
```

### Emit LLVM IR

```bash
./scripts/emit_ir.sh basic heap_oob
```

### Dump ASM

```bash
./scripts/dump_asm.sh basic heap_oob
```

---

## 8. Notes 작성 규칙

각 케이스 note는 아래 템플릿을 기본으로 합니다.

```md
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
```

단, 실제 운영에서는 너무 장황해지지 않도록  
공통 개념은 `01_basic_concepts.md`에 모으고,  
개별 케이스 note는 **케이스 특화 내용 위주로 압축 작성**하는 것을 권장합니다.

---

## 9. 학습 로드맵

### Phase 1. Basic

- heap OOB
- heap underflow
- stack OOB
- global OOB
- use-after-free
- leak

### Phase 2. Advanced

- use-after-return
- use-after-scope
- intra-object overflow
- nonlinear cases

### Phase 3. LLVM Internals

- `AddressSanitizer.cpp`
- `instrumentAddress`
- `createSlowPathCmp`
- `getRedzoneSizeForGlobal`
- `__asan_report` 삽입 구조

### Phase 4. Limitations

- ASan miss cases
- intra-object overflow
- allocator edge cases
- partial instrumentation

---

## 10. Git 운영 전략

### 기본 커밋 예시

```bash
git add .
git commit -m "02 heap_oob 분석 완료"
```

### 커밋 기준

다음 단위로 커밋하는 것을 원칙으로 합니다.

- 코드 + 로그 + notes 완료
- IR 추가 완료
- ASM 분석 추가 완료
- notes 보강 완료

즉, **의미 있는 분석 단위**로 커밋합니다.

---

## 11. ChatGPT 사용 규칙

### 금지

- 기록 없이 질문만 반복
- 실험 결과를 notes에 남기지 않고 대화에만 의존
- 로그/IR 없이 추상적인 질문만 계속하기

### 권장

예시는 다음과 같습니다.

```text
이건 heap_oob notes인데,
IR 분석 이어서 해줘
```

핵심은 항상 **notes 기반으로 질문**하는 것입니다.

---

## 12. 컨텍스트 유지 전략

### 반드시 지킬 것

- 모든 분석은 `notes/`에 저장합니다.
- 대화 내용은 필요한 것만 정리해서 반영합니다.
- 다음 세션 시작 시 현재 상태를 먼저 공유합니다.

### 시작 템플릿 예시

```text
현재 상태:
- heap_oob 완료
- 로그/IR/ASM 확보
- notes 작성 완료

다음 목표:
- IR 분석 진행
```

이렇게 하면 세션이 바뀌어도 작업 흐름을 자연스럽게 이어갈 수 있습니다.

---

## 13. 자동화 확장 계획

추후 아래 자동화를 도입할 수 있습니다.

- `Makefile`
- `analyze.sh` (전체 자동화)
- 로그 timestamp 자동 저장
- 테스트 자동 실행
- notes 템플릿 자동 생성

---

## 14. 핵심 개념

### ASan의 본질

ASan은 다음 요소의 조합으로 동작합니다.

- shadow memory
- redzone
- compiler instrumentation
- runtime report

즉, 단순한 라이브러리가 아니라  
**컴파일러 삽입 코드 + 런타임 검사 체계**입니다.

### ASan의 한계

ASan은 poisoned memory 기반 탐지이므로,  
모든 논리적 오류를 100% 탐지할 수는 없습니다.

대표적으로 다음과 같은 한계가 존재합니다.

- intra-object overflow 일부
- nonlinear access
- allocator / custom memory path
- partial instrumentation 상황

---

## 15. 최종 결론

이 프로젝트는 단순한 ASan 사용 연습이 아닙니다.

이 프로젝트의 본질은 다음과 같습니다.

- 메모리 오류를 직접 재현하고
- ASan의 탐지 원리를 이해하며
- LLVM 내부 동작과 연결하고
- IR / ASM 수준까지 내려가 분석하고
- ASan의 한계까지 검토하는 것

즉,  
**메모리 오류 분석 + 컴파일러 내부 이해 + 보안 연구**를 위한 기록형 프로젝트입니다.
