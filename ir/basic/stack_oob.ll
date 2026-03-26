; ModuleID = 'src/basic/stack_oob.c'
source_filename = "src/basic/stack_oob.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

$asan.module_ctor = comdat any

$asan.module_dtor = comdat any

$__const.main.arr.21576b91ab9b15712202e1b4a494877f = comdat any

$.str.21576b91ab9b15712202e1b4a494877f = comdat any

$.str.1.21576b91ab9b15712202e1b4a494877f = comdat any

@__const.main.arr = internal constant { [4 x i32], [16 x i8] } { [4 x i32] [i32 0, i32 1, i32 2, i32 3], [16 x i8] zeroinitializer }, comdat($__const.main.arr.21576b91ab9b15712202e1b4a494877f), align 32
@.str = internal constant { [21 x i8], [43 x i8] } { [21 x i8] c"before overflow: %d\0A\00", [43 x i8] zeroinitializer }, comdat($.str.21576b91ab9b15712202e1b4a494877f), align 32, !dbg !0
@.str.1 = internal constant { [20 x i8], [44 x i8] } { [20 x i8] c"after overflow: %d\0A\00", [44 x i8] zeroinitializer }, comdat($.str.1.21576b91ab9b15712202e1b4a494877f), align 32, !dbg !7
@__asan_option_detect_stack_use_after_return = external global i32
@___asan_gen_ = private unnamed_addr constant [17 x i8] c"1 32 16 6 arr:10\00", align 1
@___asan_gen_.2 = private constant [22 x i8] c"src/basic/stack_oob.c\00", align 1
@___asan_gen_.3 = private unnamed_addr constant [17 x i8] c"__const.main.arr\00", align 1
@___asan_gen_.4 = private unnamed_addr constant [5 x i8] c".str\00", align 1
@___asan_gen_.5 = private unnamed_addr constant [7 x i8] c".str.1\00", align 1
@__asan_global___const.main.arr = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @0 to i64), i64 16, i64 32, i64 ptrtoint (ptr @___asan_gen_.3 to i64), i64 ptrtoint (ptr @___asan_gen_.2 to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($__const.main.arr.21576b91ab9b15712202e1b4a494877f), !associated !12
@__asan_global_.str = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @1 to i64), i64 21, i64 64, i64 ptrtoint (ptr @___asan_gen_.4 to i64), i64 ptrtoint (ptr @___asan_gen_.2 to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.21576b91ab9b15712202e1b4a494877f), !associated !13
@__asan_global_.str.1 = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @2 to i64), i64 20, i64 64, i64 ptrtoint (ptr @___asan_gen_.5 to i64), i64 ptrtoint (ptr @___asan_gen_.2 to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.1.21576b91ab9b15712202e1b4a494877f), !associated !14
@llvm.compiler.used = appending global [6 x ptr] [ptr @__const.main.arr, ptr @.str, ptr @.str.1, ptr @__asan_global___const.main.arr, ptr @__asan_global_.str, ptr @__asan_global_.str.1], section "llvm.metadata"
@___asan_globals_registered = common hidden global i64 0
@__start_asan_globals = extern_weak hidden global i64
@__stop_asan_globals = extern_weak hidden global i64
@llvm.used = appending global [2 x ptr] [ptr @asan.module_ctor, ptr @asan.module_dtor], section "llvm.metadata"
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 1, ptr @asan.module_ctor, ptr @asan.module_ctor }]
@llvm.global_dtors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 1, ptr @asan.module_dtor, ptr @asan.module_dtor }]

@0 = private alias { [4 x i32], [16 x i8] }, ptr @__const.main.arr
@1 = private alias { [21 x i8], [43 x i8] }, ptr @.str
@2 = private alias { [20 x i8], [44 x i8] }, ptr @.str.1

; Function Attrs: noinline nounwind optnone sanitize_address uwtable
define dso_local i32 @main() #0 !dbg !25 {
entry:
  %retval = alloca i32, align 4
  %asan_local_stack_base = alloca i64, align 8
  %0 = load i32, ptr @__asan_option_detect_stack_use_after_return, align 4
  %1 = icmp ne i32 %0, 0
  br i1 %1, label %2, label %4

2:                                                ; preds = %entry
  %3 = call i64 @__asan_stack_malloc_0(i64 64)
  br label %4

4:                                                ; preds = %entry, %2
  %5 = phi i64 [ 0, %entry ], [ %3, %2 ]
  %6 = icmp eq i64 %5, 0
  br i1 %6, label %7, label %9

7:                                                ; preds = %4
  %MyAlloca = alloca i8, i64 64, align 32
  %8 = ptrtoint ptr %MyAlloca to i64
  br label %9

9:                                                ; preds = %4, %7
  %10 = phi i64 [ %5, %4 ], [ %8, %7 ]
  store i64 %10, ptr %asan_local_stack_base, align 8
  %11 = add i64 %10, 32
  %12 = inttoptr i64 %11 to ptr
  %13 = inttoptr i64 %10 to ptr
  store i64 1102416563, ptr %13, align 8
  %14 = add i64 %10, 8
  %15 = inttoptr i64 %14 to ptr
  store i64 ptrtoint (ptr @___asan_gen_ to i64), ptr %15, align 8
  %16 = add i64 %10, 16
  %17 = inttoptr i64 %16 to ptr
  store i64 ptrtoint (ptr @main to i64), ptr %17, align 8
  %18 = lshr i64 %10, 3
  %19 = add i64 %18, 2147450880
  %20 = add i64 %19, 0
  %21 = inttoptr i64 %20 to ptr
  store i64 -868076555057630735, ptr %21, align 1
  store i32 0, ptr %retval, align 4
  %22 = add i64 %19, 4, !dbg !30
  %23 = inttoptr i64 %22 to ptr, !dbg !30
  store i16 0, ptr %23, align 1, !dbg !30
  call void @llvm.lifetime.start.p0(i64 16, ptr %12) #6, !dbg !30
  call void @llvm.dbg.declare(metadata ptr %asan_local_stack_base, metadata !31, metadata !DIExpression(DW_OP_deref, DW_OP_plus_uconst, 32)), !dbg !35
  %24 = call ptr @__asan_memcpy(ptr %12, ptr @__const.main.arr, i64 16), !dbg !35
  %arrayidx = getelementptr inbounds [4 x i32], ptr %12, i64 0, i64 0, !dbg !36
  %25 = load i32, ptr %arrayidx, align 16, !dbg !36
  %call = call i32 (ptr, ...) @printf(ptr noundef @.str, i32 noundef %25), !dbg !37
  %arrayidx1 = getelementptr inbounds [4 x i32], ptr %12, i64 0, i64 4, !dbg !38
  %26 = ptrtoint ptr %arrayidx1 to i64, !dbg !39
  %27 = lshr i64 %26, 3, !dbg !39
  %28 = add i64 %27, 2147450880, !dbg !39
  %29 = inttoptr i64 %28 to ptr, !dbg !39
  %30 = load i8, ptr %29, align 2, !dbg !39
  %31 = icmp ne i8 %30, 0, !dbg !39
  br i1 %31, label %32, label %38, !dbg !39, !prof !40

32:                                               ; preds = %9
  %33 = and i64 %26, 7, !dbg !39
  %34 = add i64 %33, 3, !dbg !39
  %35 = trunc i64 %34 to i8, !dbg !39
  %36 = icmp sge i8 %35, %30, !dbg !39
  br i1 %36, label %37, label %38, !dbg !39

37:                                               ; preds = %32
  call void @__asan_report_store4(i64 %26) #7, !dbg !39
  unreachable

38:                                               ; preds = %32, %9
  store i32 100, ptr %arrayidx1, align 16, !dbg !39
  %arrayidx2 = getelementptr inbounds [4 x i32], ptr %12, i64 0, i64 4, !dbg !41
  %39 = ptrtoint ptr %arrayidx2 to i64, !dbg !41
  %40 = lshr i64 %39, 3, !dbg !41
  %41 = add i64 %40, 2147450880, !dbg !41
  %42 = inttoptr i64 %41 to ptr, !dbg !41
  %43 = load i8, ptr %42, align 2, !dbg !41
  %44 = icmp ne i8 %43, 0, !dbg !41
  br i1 %44, label %45, label %51, !dbg !41, !prof !40

45:                                               ; preds = %38
  %46 = and i64 %39, 7, !dbg !41
  %47 = add i64 %46, 3, !dbg !41
  %48 = trunc i64 %47 to i8, !dbg !41
  %49 = icmp sge i8 %48, %43, !dbg !41
  br i1 %49, label %50, label %51, !dbg !41

50:                                               ; preds = %45
  call void @__asan_report_load4(i64 %39) #7, !dbg !41
  unreachable

51:                                               ; preds = %45, %38
  %52 = load i32, ptr %arrayidx2, align 16, !dbg !41
  %call3 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %52), !dbg !42
  %53 = add i64 %19, 4, !dbg !43
  %54 = inttoptr i64 %53 to ptr, !dbg !43
  store i16 -1800, ptr %54, align 1, !dbg !43
  call void @llvm.lifetime.end.p0(i64 16, ptr %12) #6, !dbg !43
  store i64 1172321806, ptr %13, align 8, !dbg !44
  %55 = icmp ne i64 %5, 0, !dbg !44
  br i1 %55, label %56, label %63, !dbg !44

56:                                               ; preds = %51
  %57 = add i64 %19, 0, !dbg !44
  %58 = inttoptr i64 %57 to ptr, !dbg !44
  store i64 -723401728380766731, ptr %58, align 1, !dbg !44
  %59 = add i64 %5, 56, !dbg !44
  %60 = inttoptr i64 %59 to ptr, !dbg !44
  %61 = load i64, ptr %60, align 8, !dbg !44
  %62 = inttoptr i64 %61 to ptr, !dbg !44
  store i8 0, ptr %62, align 1, !dbg !44
  br label %66, !dbg !44

63:                                               ; preds = %51
  %64 = add i64 %19, 0, !dbg !44
  %65 = inttoptr i64 %64 to ptr, !dbg !44
  store i64 0, ptr %65, align 1, !dbg !44
  br label %66, !dbg !44

66:                                               ; preds = %63, %56
  ret i32 0, !dbg !44
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #3

declare i32 @printf(ptr noundef, ...) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

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

declare i64 @__asan_stack_malloc_0(i64)

declare void @__asan_stack_free_0(i64, i64)

declare i64 @__asan_stack_malloc_1(i64)

declare void @__asan_stack_free_1(i64, i64)

declare i64 @__asan_stack_malloc_2(i64)

declare void @__asan_stack_free_2(i64, i64)

declare i64 @__asan_stack_malloc_3(i64)

declare void @__asan_stack_free_3(i64, i64)

declare i64 @__asan_stack_malloc_4(i64)

declare void @__asan_stack_free_4(i64, i64)

declare i64 @__asan_stack_malloc_5(i64)

declare void @__asan_stack_free_5(i64, i64)

declare i64 @__asan_stack_malloc_6(i64)

declare void @__asan_stack_free_6(i64, i64)

declare i64 @__asan_stack_malloc_7(i64)

declare void @__asan_stack_free_7(i64, i64)

declare i64 @__asan_stack_malloc_8(i64)

declare void @__asan_stack_free_8(i64, i64)

declare i64 @__asan_stack_malloc_9(i64)

declare void @__asan_stack_free_9(i64, i64)

declare i64 @__asan_stack_malloc_10(i64)

declare void @__asan_stack_free_10(i64, i64)

declare void @__asan_poison_stack_memory(i64, i64)

declare void @__asan_unpoison_stack_memory(i64, i64)

declare void @__asan_set_shadow_00(i64, i64)

declare void @__asan_set_shadow_01(i64, i64)

declare void @__asan_set_shadow_02(i64, i64)

declare void @__asan_set_shadow_03(i64, i64)

declare void @__asan_set_shadow_04(i64, i64)

declare void @__asan_set_shadow_05(i64, i64)

declare void @__asan_set_shadow_06(i64, i64)

declare void @__asan_set_shadow_07(i64, i64)

declare void @__asan_set_shadow_f1(i64, i64)

declare void @__asan_set_shadow_f2(i64, i64)

declare void @__asan_set_shadow_f3(i64, i64)

declare void @__asan_set_shadow_f5(i64, i64)

declare void @__asan_set_shadow_f8(i64, i64)

declare void @__asan_alloca_poison(i64, i64)

declare void @__asan_allocas_unpoison(i64, i64)

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
define internal void @asan.module_ctor() #5 comdat {
  call void @__asan_init()
  call void @__asan_version_mismatch_check_v8()
  call void @__asan_register_elf_globals(i64 ptrtoint (ptr @___asan_globals_registered to i64), i64 ptrtoint (ptr @__start_asan_globals to i64), i64 ptrtoint (ptr @__stop_asan_globals to i64))
  ret void
}

declare void @__asan_version_mismatch_check_v8()

; Function Attrs: nounwind uwtable
define internal void @asan.module_dtor() #5 comdat {
  call void @__asan_unregister_elf_globals(i64 ptrtoint (ptr @___asan_globals_registered to i64), i64 ptrtoint (ptr @__start_asan_globals to i64), i64 ptrtoint (ptr @__stop_asan_globals to i64))
  ret void
}

attributes #0 = { noinline nounwind optnone sanitize_address uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #4 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind uwtable "frame-pointer"="all" }
attributes #6 = { nounwind }
attributes #7 = { nomerge }

!llvm.dbg.cu = !{!15}
!llvm.module.flags = !{!17, !18, !19, !20, !21, !22, !23}
!llvm.ident = !{!24}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 12, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "src/basic/stack_oob.c", directory: "/home/user/asan_study", checksumkind: CSK_MD5, checksum: "aa4986b3b4b7537a8a02027d2f4c800f")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 168, elements: !5)
!4 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!5 = !{!6}
!6 = !DISubrange(count: 21)
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(scope: null, file: !2, line: 16, type: !9, isLocal: true, isDefinition: true)
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !10)
!10 = !{!11}
!11 = !DISubrange(count: 20)
!12 = !{ptr @__const.main.arr}
!13 = !{ptr @.str}
!14 = !{ptr @.str.1}
!15 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !16, splitDebugInlining: false, nameTableKind: None)
!16 = !{!0, !7}
!17 = !{i32 7, !"Dwarf Version", i32 5}
!18 = !{i32 2, !"Debug Info Version", i32 3}
!19 = !{i32 1, !"wchar_size", i32 4}
!20 = !{i32 8, !"PIC Level", i32 2}
!21 = !{i32 7, !"PIE Level", i32 2}
!22 = !{i32 7, !"uwtable", i32 2}
!23 = !{i32 7, !"frame-pointer", i32 2}
!24 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!25 = distinct !DISubprogram(name: "main", scope: !2, file: !2, line: 8, type: !26, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !15, retainedNodes: !29)
!26 = !DISubroutineType(types: !27)
!27 = !{!28}
!28 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!29 = !{}
!30 = !DILocation(line: 10, column: 5, scope: !25)
!31 = !DILocalVariable(name: "arr", scope: !25, file: !2, line: 10, type: !32)
!32 = !DICompositeType(tag: DW_TAG_array_type, baseType: !28, size: 128, elements: !33)
!33 = !{!34}
!34 = !DISubrange(count: 4)
!35 = !DILocation(line: 10, column: 9, scope: !25)
!36 = !DILocation(line: 12, column: 37, scope: !25)
!37 = !DILocation(line: 12, column: 5, scope: !25)
!38 = !DILocation(line: 14, column: 5, scope: !25)
!39 = !DILocation(line: 14, column: 12, scope: !25)
!40 = !{!"branch_weights", i32 1, i32 100000}
!41 = !DILocation(line: 16, column: 36, scope: !25)
!42 = !DILocation(line: 16, column: 5, scope: !25)
!43 = !DILocation(line: 19, column: 1, scope: !25)
!44 = !DILocation(line: 18, column: 5, scope: !25)
