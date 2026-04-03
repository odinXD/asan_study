# [07] leak

## 1. 개요
- Bug Type: memory-leak
- CWE: CWE-401
- Category: basic

## 2. 코드 설명
- `make_leak()`에서 `malloc(64)`로 heap 64바이트 할당
- 반환된 포인터를 지역변수 `p`에 저장
- `free(p)`를 호출하지 않고 함수 종료
- 함수가 끝나면서 포인터는 사라지지만, heap 블록은 해제되지 않은 채 남음

## 3. 실행
- build/run 완료
- LeakSanitizer가 프로그램 종료 시 memory leak을 보고

## 4. 결과
- 누수 크기: `64 byte(s)`
- 누수 객체 수: `1 object(s)`
- 누수 발생 위치: `make_leak /home/user/asan_study/src/basic/leak.c:10:15`
- 최종 요약: `64 byte(s) leaked in 1 allocation(s)`

## 5. 핵심 로그
- `LeakSanitizer: detected memory leaks`
- `Direct leak of 64 byte(s) in 1 object(s) allocated from:`
- `#1 ... in make_leak /home/user/asan_study/src/basic/leak.c:10:15`
- `SUMMARY: AddressSanitizer: 64 byte(s) leaked in 1 allocation(s).`

## 6. 왜 잡혔는가
- `malloc(64)`로 heap 메모리를 할당했지만 `free()`를 호출하지 않았다.
- 포인터 `p`는 `make_leak()`의 지역변수이므로 함수 종료 후 lifetime이 끝난다.
- 그 결과 해당 heap 블록은 해제되지 않은 채 남고, 더 이상 도달할 수 없는 상태가 된다.
- LeakSanitizer는 프로그램 종료 시점에 남아 있는 heap allocation을 검사한다.
- 이번 케이스에서는 누수된 블록이 직접적으로 잃어버린 상태이므로 `Direct leak`으로 보고되었다.
- 이번 케이스는 redzone 침범이나 freed region 접근이 아니라, **해제 누락에 의한 memory leak** 검출이다.

## 7. IR 분석
- `main`은 `call void @make_leak()` 후 `ret i32 0`으로 끝나는 단순 구조다.
- 실제 leak 발생 지점은 `make_leak()` 내부의 `call noalias ptr @malloc(i64 noundef 64)`이다.
- 반환된 heap 주소는 `store ptr %call, ptr %p`를 통해 지역 포인터 변수 `p`에 저장된다.
- 이후 `free()` 호출은 존재하지 않는다.
- `llvm.lifetime.start/end`는 heap 블록이 아니라 지역변수 `p`의 stack lifetime을 나타낸다.
- 즉, IR 관점에서 이번 leak의 핵심은 **malloc은 존재하지만 free가 없고, 포인터 변수의 lifetime만 종료된다**는 점이다.
- `__asan_report_store*`, `__asan_report_load*` 계열 선언은 존재하지만, 이번 본문 경로에서는 직접 호출되지 않는다.
- 이는 이번 예제가 OOB/UAF 같은 접근 위반이 아니라, 종료 시 runtime이 수행하는 leak 검출 중심 사례이기 때문이다.

## 8. ASM 분석
- `main` 디스어셈블은 표준 프롤로그/에필로그와 `call <make_leak>` 중심의 단순한 형태다.
- `main` 자체에는 눈에 띄는 ASan shadow 검사 흐름이 없다.
- 즉 실제 문제 동작은 `main`이 아니라 `make_leak()` 내부에서 발생한다.
- 이번 케이스는 잘못된 load/store를 수행하는 예제가 아니므로, OOB/UAF 때처럼 `__asan_report_store4`로 이어지는 검사 흐름이 핵심이 아니다.
- 핵심은 `malloc`으로 얻은 heap 블록이 해제되지 않은 채 함수가 끝난다는 점이다.
- 따라서 leak 보고는 실행 도중 즉시 발생하는 것이 아니라, **프로그램 종료 시 LeakSanitizer runtime 검사 단계에서 발생한다.**

## 9. 핵심 개념
- memory leak
- direct leak
- missing free
- unreachable allocation
- heap lifetime
- LeakSanitizer

## 10. 결론
- 이번 예제는 잘못된 메모리 접근이 아니라, heap 메모리를 해제하지 않아 발생한 memory leak의 기본 사례이다.
- LeakSanitizer는 프로그램 종료 시점에 해제되지 않고 남은 heap allocation을 추적하여 이를 보고한다.
- 즉, 이번 검출의 본질은 경계 위반이 아니라 **메모리 lifetime 관리 실패**이다.

## 11. 확장
- `free(p)` 추가 후 leak이 사라지는지 비교
- 전역 포인터에 저장한 경우 direct leak 보고 차이 확인
- reachable leak / unreachable leak 비교
- `malloc` 크기를 바꿨을 때 보고 형태 비교