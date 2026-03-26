## redzone에 바로 접근해서 감지되는 것이 아님
- 컴파일러에서 삽입한 계측에 의해 접근 하기 전 유효한 영역인지 shadow byte를 통해 검증
- poison, redzone(heap 기준 fa) 인지 확인되면 _asan_report_** 호출


## 쉐도우 메모리의 오프셋?
- 타겟 OS, 아키텍처, ABI 별로 정해진 기본 후보 존재
- 동적 shadow base를 사용해서 런타임에 정해질 수도 있다.. (asan_shadow_offset)
- shadow = (mem >> Scale) + Offset (기본 scale = 3)
- getShadowMapping(...) -> OS, 아키텍처에 따라 분기
- Scale 또한 옵션이나 타겟에 따라 달라질 수 있다 (정밀도 <-> 메모리 오버헤드)

* use_shadow_mmap, guard_shadow_memory, asan_shadow_offset, detect_leaks,,,,etc


## heap 기준 redzone 배치 ([L ... L][H H][U ... U][R ... R])
- L: left redzone, H: chunk header, U: user mem, R: right redzone
- chunk header 또한 left redzone의 일부 (기본 16바이트?)
- ASAN_OPTIONS=redzone=..., max_redzone=... -> **유동 조절 가능**
- 보통 2^N 사이즈 후보, **ComputeRZLog(user_requested_size)**로 유동 할당 + min/max로 clamp

**추정??? 질문 필요 (heap)
1. 24B 요청은 alignment에 따라 rounded_size 32B가 된다.
2. 초기 needed_size는 rounded_size + rz_size이고, primary면 보통 48B, secondary면 right redzone 수동 확보 때문에 64B가 될 수 있다.
3. alloc_beg + rz_size를 user 시작 후보로 잡고, alignment가 필요하면 user_beg를 뒤로 민다. 이때 생기는 left padding은 보통 처음 확보한 needed_size 범위 안에서 처리된다.
4. chunk_beg = user_beg - 16이므로 header 16B는 user 바로 앞에 놓이며 left redzone 일부다.
5. right redzone은 개념적으로 rz_size 기준이지만, 실제 poison 구간은 최종 user_end와 실제 allocator가 준 chunk 크기에 따라 정해진다.

### primary / secondary allocator
- primary allocator : 작은/보통 크기 할당 빠르게 처리
- secondary allocator : 큰 할당이나, primary 로 처리 힘든 경우 (OS 에서 직접 매핑받는 느낌...??)


## redzone : heap vs stack
- heap : 할당 단위: heap chunk, runtime allocator 기준으로 redzone 생성
- stack : 함수의 지역 변수 대상, '컴파일러'가 함수 프레임 재구성하여 redzone 생성 (확장된 stack frame -> shadow 세팅)


## global array(object)
- 원래 객체 + redzone -> 관리 단위
- 컴파일 시점에 전역 객체 레이아웃/메타데이터가 바뀐다
- 런타임 시점에서 shadow poisoning/register(?) 수행됨

** global ????
global_oob 테스트 중 global_buffer 범위의 shadow 배치에서,
user memory 영역 뒤에는 16바이트의 redzone 정상 위치 해있었으나,
이전 영역에는 그대로 00으로 채워져있었음 (addressable)
-> 전역은 heap, stack 보다는 배치 의존성이 있고, 실제로 해당 테스트 중에서는 left underflow가 가능한 상황이었다(?)

A. heap
- 결정 주체: ASan allocator
- 결정 시점: 런타임 할당 시
- 기준: 요청 크기, alignment, min/max redzone
- 배치 형태: chunk 기준 left / right redzone
- 특징: adaptive redzone, 1:1 고정 아님
- 탐지 방식: shadow poison + access 전 검사

B. stack
- 결정 주체: compiler instrumentation
- 결정 시점: 컴파일 시 frame 재구성
- 기준: 지역변수 크기, 정렬, frame layout
- 배치 형태: left / mid / right redzone
- 특징: frame 전체 기준으로 layout 계산
- 탐지 방식: shadow poison + access 전 검사

C. global
- 결정 주체: compiler instrumentation + global metadata
- 결정 시점: 컴파일 시 재작성, 런타임 초기화 시 등록/poison
- 기준: 객체 크기, 최소 redzone 단위, global rule
- 배치 형태: { object, right_redzone } 형태가 공식 테스트에서 확인됨
- 특징: adaptive global redzone, 1:1 고정 아님
- 탐지 방식: shadow poison + access 전 검사


## slow path check (partial addressable....)
- 0 (addressable) 이 아니라고 해서 바로 오류를 띄우는 것이 아님
- 1, 2, 4, 8바이트 등 실제 허용된 범위를 넘는가? 판단
- ex. (addr & 7) -> (offset + 3) -> partial shadow 와 비교
