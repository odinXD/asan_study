# ASan Study

AddressSanitizer를 단순히 사용해보는 수준을 넘어서,  
메모리 오류를 직접 재현하고, 탐지 원리를 이해하며,  
LLVM instrumentation과 IR/ASM 수준까지 연결해서 분석하는 학습 프로젝트입니다.

## Goals

- Reproduce memory bugs directly
- Understand how ASan detects errors
- Connect runtime reports to LLVM IR and assembly
- Analyze AddressSanitizer internals in LLVM
- Study ASan limitations and miss cases

## Project Scope

이 프로젝트는 다음 내용을 단계적으로 다룹니다.

- basic memory bug cases
- advanced ASan cases
- LLVM AddressSanitizer internals
- runtime report / shadow memory / redzone analysis
- ASan이 탐지하지 못하는 한계 사례 분석

## Directory Layout

```text
asan-study/
├─ src/        # test source code
├─ bin/        # built binaries
├─ logs/       # runtime logs
├─ ir/         # emitted LLVM IR
├─ asm/        # assembly dumps
├─ notes/      # study notes and analysis
├─ scripts/    # helper scripts
├─ README.md
├─ GUIDELINE.md
├─ build.sh
├─ run.sh
└─ clean.sh
```

## Workflow

1. Write code
2. Build
3. Run and collect logs
4. Emit LLVM IR
5. Dump assembly
6. Write notes
7. Commit changes
8. Continue deeper analysis

## Quick Start

### Build

```bash
./build.sh basic heap_oob
```

### Run

```bash
./run.sh basic heap_oob
```

### Emit IR

```bash
./scripts/emit_ir.sh basic heap_oob
```

### Dump ASM

```bash
./scripts/dump_asm.sh basic heap_oob
```

## Documents

- [Project Guideline](GUIDELINE.md)
- [Notes Index](notes/index.md)
- [Progress](notes/progress.md)

## Current Focus

- Basic ASan case studies
- IR / ASM correlation
- Shadow memory and redzone behavior
- LLVM AddressSanitizer implementation flow

## Purpose

이 저장소는 단순 실습 모음이 아니라,  
메모리 오류 분석, 컴파일러 내부 이해, 보안 관점 연구를 함께 진행하기 위한 기록형 프로젝트입니다.
