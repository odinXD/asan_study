; ModuleID = 'src/basic/global_oob.c'
source_filename = "src/basic/global_oob.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

$asan.module_ctor = comdat any

$asan.module_dtor = comdat any

$global_buffer = comdat any

$.str.86d95ca7f1e78983cade8d7ccce987a9 = comdat any

$.str.1.86d95ca7f1e78983cade8d7ccce987a9 = comdat any

$.str.2.86d95ca7f1e78983cade8d7ccce987a9 = comdat any

$.str.3.86d95ca7f1e78983cade8d7ccce987a9 = comdat any

$.str.4.86d95ca7f1e78983cade8d7ccce987a9 = comdat any

@global_buffer = dso_local global { [4 x i32], [16 x i8] } { [4 x i32] [i32 10, i32 20, i32 30, i32 40], [16 x i8] zeroinitializer }, comdat, align 32, !dbg !0
@.str = internal constant { [23 x i8], [41 x i8] } { [23 x i8] c"global_buffer[0] = %d\0A\00", [41 x i8] zeroinitializer }, comdat($.str.86d95ca7f1e78983cade8d7ccce987a9), align 32, !dbg !5
@.str.1 = internal constant { [23 x i8], [41 x i8] } { [23 x i8] c"global_buffer[1] = %d\0A\00", [41 x i8] zeroinitializer }, comdat($.str.1.86d95ca7f1e78983cade8d7ccce987a9), align 32, !dbg !11
@.str.2 = internal constant { [23 x i8], [41 x i8] } { [23 x i8] c"global_buffer[2] = %d\0A\00", [41 x i8] zeroinitializer }, comdat($.str.2.86d95ca7f1e78983cade8d7ccce987a9), align 32, !dbg !13
@.str.3 = internal constant { [23 x i8], [41 x i8] } { [23 x i8] c"global_buffer[3] = %d\0A\00", [41 x i8] zeroinitializer }, comdat($.str.3.86d95ca7f1e78983cade8d7ccce987a9), align 32, !dbg !15
@.str.4 = internal constant { [37 x i8], [59 x i8] } { [37 x i8] c"This line should not be reached: %d\0A\00", [59 x i8] zeroinitializer }, comdat($.str.4.86d95ca7f1e78983cade8d7ccce987a9), align 32, !dbg !17
@___asan_gen_ = private constant [23 x i8] c"src/basic/global_oob.c\00", align 1
@___asan_gen_.5 = private unnamed_addr constant [14 x i8] c"global_buffer\00", align 1
@__odr_asan_gen_global_buffer = global i8 0, align 1
@___asan_gen_.6 = private unnamed_addr constant [5 x i8] c".str\00", align 1
@___asan_gen_.7 = private unnamed_addr constant [7 x i8] c".str.1\00", align 1
@___asan_gen_.8 = private unnamed_addr constant [7 x i8] c".str.2\00", align 1
@___asan_gen_.9 = private unnamed_addr constant [7 x i8] c".str.3\00", align 1
@___asan_gen_.10 = private unnamed_addr constant [7 x i8] c".str.4\00", align 1
@__asan_global_global_buffer = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @0 to i64), i64 16, i64 32, i64 ptrtoint (ptr @___asan_gen_.5 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 ptrtoint (ptr @__odr_asan_gen_global_buffer to i64) }, section "asan_globals", comdat($global_buffer), !associated !26
@__asan_global_.str = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @1 to i64), i64 23, i64 64, i64 ptrtoint (ptr @___asan_gen_.6 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.86d95ca7f1e78983cade8d7ccce987a9), !associated !27
@__asan_global_.str.1 = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @2 to i64), i64 23, i64 64, i64 ptrtoint (ptr @___asan_gen_.7 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.1.86d95ca7f1e78983cade8d7ccce987a9), !associated !28
@__asan_global_.str.2 = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @3 to i64), i64 23, i64 64, i64 ptrtoint (ptr @___asan_gen_.8 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.2.86d95ca7f1e78983cade8d7ccce987a9), !associated !29
@__asan_global_.str.3 = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @4 to i64), i64 23, i64 64, i64 ptrtoint (ptr @___asan_gen_.9 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.3.86d95ca7f1e78983cade8d7ccce987a9), !associated !30
@__asan_global_.str.4 = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @5 to i64), i64 37, i64 96, i64 ptrtoint (ptr @___asan_gen_.10 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.4.86d95ca7f1e78983cade8d7ccce987a9), !associated !31
@llvm.compiler.used = appending global [12 x ptr] [ptr @global_buffer, ptr @.str, ptr @.str.1, ptr @.str.2, ptr @.str.3, ptr @.str.4, ptr @__asan_global_global_buffer, ptr @__asan_global_.str, ptr @__asan_global_.str.1, ptr @__asan_global_.str.2, ptr @__asan_global_.str.3, ptr @__asan_global_.str.4], section "llvm.metadata"
@___asan_globals_registered = common hidden global i64 0
@__start_asan_globals = extern_weak hidden global i64
@__stop_asan_globals = extern_weak hidden global i64
@llvm.used = appending global [2 x ptr] [ptr @asan.module_ctor, ptr @asan.module_dtor], section "llvm.metadata"
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 1, ptr @asan.module_ctor, ptr @asan.module_ctor }]
@llvm.global_dtors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 1, ptr @asan.module_dtor, ptr @asan.module_dtor }]

@0 = private alias { [4 x i32], [16 x i8] }, ptr @global_buffer
@1 = private alias { [23 x i8], [41 x i8] }, ptr @.str
@2 = private alias { [23 x i8], [41 x i8] }, ptr @.str.1
@3 = private alias { [23 x i8], [41 x i8] }, ptr @.str.2
@4 = private alias { [23 x i8], [41 x i8] }, ptr @.str.3
@5 = private alias { [37 x i8], [59 x i8] }, ptr @.str.4

; Function Attrs: noinline nounwind optnone sanitize_address uwtable
define dso_local i32 @main() #0 !dbg !40 {
entry:
  %retval = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  %0 = load i32, ptr @global_buffer, align 16, !dbg !43
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %0), !dbg !44
  %1 = load i32, ptr getelementptr inbounds ([4 x i32], ptr @global_buffer, i64 0, i64 1), align 4, !dbg !45
  %call1 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %1), !dbg !46
  %2 = load i32, ptr getelementptr inbounds ([4 x i32], ptr @global_buffer, i64 0, i64 2), align 8, !dbg !47
  %call2 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %2), !dbg !48
  %3 = load i32, ptr getelementptr inbounds ([4 x i32], ptr @global_buffer, i64 0, i64 3), align 4, !dbg !49
  %call3 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %3), !dbg !50
  %4 = lshr i64 ptrtoint (ptr getelementptr inbounds ([4 x i32], ptr @global_buffer, i64 1, i64 0) to i64), 3, !dbg !51
  %5 = add i64 %4, 2147450880, !dbg !51
  %6 = inttoptr i64 %5 to ptr, !dbg !51
  %7 = load i8, ptr %6, align 2, !dbg !51
  %8 = icmp ne i8 %7, 0, !dbg !51
  br i1 %8, label %9, label %15, !dbg !51, !prof !52

9:                                                ; preds = %entry
  %10 = and i64 ptrtoint (ptr getelementptr inbounds ([4 x i32], ptr @global_buffer, i64 1, i64 0) to i64), 7, !dbg !51
  %11 = add i64 %10, 3, !dbg !51
  %12 = trunc i64 %11 to i8, !dbg !51
  %13 = icmp sge i8 %12, %7, !dbg !51
  br i1 %13, label %14, label %15, !dbg !51

14:                                               ; preds = %9
  call void @__asan_report_store4(i64 ptrtoint (ptr getelementptr inbounds ([4 x i32], ptr @global_buffer, i64 1, i64 0) to i64)) #4, !dbg !51
  unreachable

15:                                               ; preds = %9, %entry
  store i32 999, ptr getelementptr inbounds ([4 x i32], ptr @global_buffer, i64 1, i64 0), align 16, !dbg !51
  %16 = load i32, ptr getelementptr inbounds ([4 x i32], ptr @global_buffer, i64 1, i64 0), align 16, !dbg !53
  %call4 = call i32 (ptr, ...) @printf(ptr noundef @.str.4, i32 noundef %16), !dbg !54
  ret i32 0, !dbg !55
}

declare i32 @printf(ptr noundef, ...) #1

declare void @__asan_report_load_n(i64, i64)

declare void @__asan_loadN(i64, i64)

declare void @__asan_report_load1(i64)

declare void @__asan_load1(i64)

declare void @__asan_report_load2(i64)

declare void @__asan_load2(i64)

declare void @__asan_report_load4(i64)

declare void @__asan_load4(i64)

declare void @__asan_report_load8(i64)

declare void @__asan_load8(i64)

declare void @__asan_report_load16(i64)

declare void @__asan_load16(i64)

declare void @__asan_report_store_n(i64, i64)

declare void @__asan_storeN(i64, i64)

declare void @__asan_report_store1(i64)

declare void @__asan_store1(i64)

declare void @__asan_report_store2(i64)

declare void @__asan_store2(i64)

declare void @__asan_report_store4(i64)

declare void @__asan_store4(i64)

declare void @__asan_report_store8(i64)

declare void @__asan_store8(i64)

declare void @__asan_report_store16(i64)

declare void @__asan_store16(i64)

declare void @__asan_report_exp_load_n(i64, i64, i32)

declare void @__asan_exp_loadN(i64, i64, i32)

declare void @__asan_report_exp_load1(i64, i32)

declare void @__asan_exp_load1(i64, i32)

declare void @__asan_report_exp_load2(i64, i32)

declare void @__asan_exp_load2(i64, i32)

declare void @__asan_report_exp_load4(i64, i32)

declare void @__asan_exp_load4(i64, i32)

declare void @__asan_report_exp_load8(i64, i32)

declare void @__asan_exp_load8(i64, i32)

declare void @__asan_report_exp_load16(i64, i32)

declare void @__asan_exp_load16(i64, i32)

declare void @__asan_report_exp_store_n(i64, i64, i32)

declare void @__asan_exp_storeN(i64, i64, i32)

declare void @__asan_report_exp_store1(i64, i32)

declare void @__asan_exp_store1(i64, i32)

declare void @__asan_report_exp_store2(i64, i32)

declare void @__asan_exp_store2(i64, i32)

declare void @__asan_report_exp_store4(i64, i32)

declare void @__asan_exp_store4(i64, i32)

declare void @__asan_report_exp_store8(i64, i32)

declare void @__asan_exp_store8(i64, i32)

declare void @__asan_report_exp_store16(i64, i32)

declare void @__asan_exp_store16(i64, i32)

declare ptr @__asan_memmove(ptr, ptr, i64)

declare ptr @__asan_memcpy(ptr, ptr, i64)

declare ptr @__asan_memset(ptr, i32, i64)

declare void @__asan_handle_no_return()

declare void @__sanitizer_ptr_cmp(i64, i64)

declare void @__sanitizer_ptr_sub(i64, i64)

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.amdgcn.is.shared(ptr nocapture) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i1 @llvm.amdgcn.is.private(ptr nocapture) #2

declare void @__asan_before_dynamic_init(i64)

declare void @__asan_after_dynamic_init()

declare void @__asan_register_globals(i64, i64)

declare void @__asan_unregister_globals(i64, i64)

declare void @__asan_register_image_globals(i64)

declare void @__asan_unregister_image_globals(i64)

declare void @__asan_register_elf_globals(i64, i64, i64)

declare void @__asan_unregister_elf_globals(i64, i64, i64)

declare void @__asan_init()

; Function Attrs: nounwind uwtable
define internal void @asan.module_ctor() #3 comdat {
  call void @__asan_init()
  call void @__asan_version_mismatch_check_v8()
  call void @__asan_register_elf_globals(i64 ptrtoint (ptr @___asan_globals_registered to i64), i64 ptrtoint (ptr @__start_asan_globals to i64), i64 ptrtoint (ptr @__stop_asan_globals to i64))
  ret void
}

declare void @__asan_version_mismatch_check_v8()

; Function Attrs: nounwind uwtable
define internal void @asan.module_dtor() #3 comdat {
  call void @__asan_unregister_elf_globals(i64 ptrtoint (ptr @___asan_globals_registered to i64), i64 ptrtoint (ptr @__start_asan_globals to i64), i64 ptrtoint (ptr @__stop_asan_globals to i64))
  ret void
}

attributes #0 = { noinline nounwind optnone sanitize_address uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nounwind uwtable "frame-pointer"="all" }
attributes #4 = { nomerge }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!32, !33, !34, !35, !36, !37, !38}
!llvm.ident = !{!39}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "global_buffer", scope: !2, file: !3, line: 8, type: !22, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C11, file: !3, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !4, splitDebugInlining: false, nameTableKind: None)
!3 = !DIFile(filename: "src/basic/global_oob.c", directory: "/home/user/asan_study", checksumkind: CSK_MD5, checksum: "019b69d0274a26eba3149ed30c5dfbbd")
!4 = !{!0, !5, !11, !13, !15, !17}
!5 = !DIGlobalVariableExpression(var: !6, expr: !DIExpression())
!6 = distinct !DIGlobalVariable(scope: null, file: !3, line: 12, type: !7, isLocal: true, isDefinition: true)
!7 = !DICompositeType(tag: DW_TAG_array_type, baseType: !8, size: 184, elements: !9)
!8 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!9 = !{!10}
!10 = !DISubrange(count: 23)
!11 = !DIGlobalVariableExpression(var: !12, expr: !DIExpression())
!12 = distinct !DIGlobalVariable(scope: null, file: !3, line: 13, type: !7, isLocal: true, isDefinition: true)
!13 = !DIGlobalVariableExpression(var: !14, expr: !DIExpression())
!14 = distinct !DIGlobalVariable(scope: null, file: !3, line: 14, type: !7, isLocal: true, isDefinition: true)
!15 = !DIGlobalVariableExpression(var: !16, expr: !DIExpression())
!16 = distinct !DIGlobalVariable(scope: null, file: !3, line: 15, type: !7, isLocal: true, isDefinition: true)
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(scope: null, file: !3, line: 19, type: !19, isLocal: true, isDefinition: true)
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !8, size: 296, elements: !20)
!20 = !{!21}
!21 = !DISubrange(count: 37)
!22 = !DICompositeType(tag: DW_TAG_array_type, baseType: !23, size: 128, elements: !24)
!23 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!24 = !{!25}
!25 = !DISubrange(count: 4)
!26 = !{ptr @global_buffer}
!27 = !{ptr @.str}
!28 = !{ptr @.str.1}
!29 = !{ptr @.str.2}
!30 = !{ptr @.str.3}
!31 = !{ptr @.str.4}
!32 = !{i32 7, !"Dwarf Version", i32 5}
!33 = !{i32 2, !"Debug Info Version", i32 3}
!34 = !{i32 1, !"wchar_size", i32 4}
!35 = !{i32 8, !"PIC Level", i32 2}
!36 = !{i32 7, !"PIE Level", i32 2}
!37 = !{i32 7, !"uwtable", i32 2}
!38 = !{i32 7, !"frame-pointer", i32 2}
!39 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!40 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 10, type: !41, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2)
!41 = !DISubroutineType(types: !42)
!42 = !{!23}
!43 = !DILocation(line: 12, column: 39, scope: !40)
!44 = !DILocation(line: 12, column: 5, scope: !40)
!45 = !DILocation(line: 13, column: 39, scope: !40)
!46 = !DILocation(line: 13, column: 5, scope: !40)
!47 = !DILocation(line: 14, column: 39, scope: !40)
!48 = !DILocation(line: 14, column: 5, scope: !40)
!49 = !DILocation(line: 15, column: 39, scope: !40)
!50 = !DILocation(line: 15, column: 5, scope: !40)
!51 = !DILocation(line: 17, column: 22, scope: !40)
!52 = !{!"branch_weights", i32 1, i32 100000}
!53 = !DILocation(line: 19, column: 53, scope: !40)
!54 = !DILocation(line: 19, column: 5, scope: !40)
!55 = !DILocation(line: 21, column: 5, scope: !40)
