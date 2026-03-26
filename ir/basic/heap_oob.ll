; ModuleID = 'src/basic/heap_oob.c'
source_filename = "src/basic/heap_oob.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

$asan.module_ctor = comdat any

$asan.module_dtor = comdat any

$.str.21576b91ab9b15712202e1b4a494877f = comdat any

$.str.1.21576b91ab9b15712202e1b4a494877f = comdat any

$.str.2.21576b91ab9b15712202e1b4a494877f = comdat any

@.str = internal constant { [15 x i8], [17 x i8] } { [15 x i8] c"malloc failed\0A\00", [17 x i8] zeroinitializer }, comdat($.str.21576b91ab9b15712202e1b4a494877f), align 32, !dbg !0
@.str.1 = internal constant { [16 x i8], [16 x i8] } { [16 x i8] c"before bug: %d\0A\00", [16 x i8] zeroinitializer }, comdat($.str.1.21576b91ab9b15712202e1b4a494877f), align 32, !dbg !7
@.str.2 = internal constant { [15 x i8], [17 x i8] } { [15 x i8] c"after bug: %d\0A\00", [17 x i8] zeroinitializer }, comdat($.str.2.21576b91ab9b15712202e1b4a494877f), align 32, !dbg !12
@___asan_gen_ = private constant [21 x i8] c"src/basic/heap_oob.c\00", align 1
@___asan_gen_.3 = private unnamed_addr constant [5 x i8] c".str\00", align 1
@___asan_gen_.4 = private unnamed_addr constant [7 x i8] c".str.1\00", align 1
@___asan_gen_.5 = private unnamed_addr constant [7 x i8] c".str.2\00", align 1
@__asan_global_.str = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @0 to i64), i64 15, i64 32, i64 ptrtoint (ptr @___asan_gen_.3 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.21576b91ab9b15712202e1b4a494877f), !associated !14
@__asan_global_.str.1 = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @1 to i64), i64 16, i64 32, i64 ptrtoint (ptr @___asan_gen_.4 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.1.21576b91ab9b15712202e1b4a494877f), !associated !15
@__asan_global_.str.2 = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @2 to i64), i64 15, i64 32, i64 ptrtoint (ptr @___asan_gen_.5 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.2.21576b91ab9b15712202e1b4a494877f), !associated !16
@llvm.compiler.used = appending global [6 x ptr] [ptr @.str, ptr @.str.1, ptr @.str.2, ptr @__asan_global_.str, ptr @__asan_global_.str.1, ptr @__asan_global_.str.2], section "llvm.metadata"
@___asan_globals_registered = common hidden global i64 0
@__start_asan_globals = extern_weak hidden global i64
@__stop_asan_globals = extern_weak hidden global i64
@llvm.used = appending global [2 x ptr] [ptr @asan.module_ctor, ptr @asan.module_dtor], section "llvm.metadata"
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 1, ptr @asan.module_ctor, ptr @asan.module_ctor }]
@llvm.global_dtors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 1, ptr @asan.module_dtor, ptr @asan.module_dtor }]

@0 = private alias { [15 x i8], [17 x i8] }, ptr @.str
@1 = private alias { [16 x i8], [16 x i8] }, ptr @.str.1
@2 = private alias { [15 x i8], [17 x i8] }, ptr @.str.2

; Function Attrs: noinline nounwind optnone sanitize_address uwtable
define dso_local i32 @main() #0 !dbg !31 {
entry:
  %retval = alloca i32, align 4
  %arr = alloca ptr, align 8
  %cleanup.dest.slot = alloca i32, align 4
  %i = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr %arr) #7, !dbg !35
  call void @llvm.dbg.declare(metadata ptr %arr, metadata !36, metadata !DIExpression()), !dbg !37
  %call = call noalias ptr @malloc(i64 noundef 16) #8, !dbg !38
  store ptr %call, ptr %arr, align 8, !dbg !37
  %0 = load ptr, ptr %arr, align 8, !dbg !39
  %cmp = icmp eq ptr %0, null, !dbg !41
  br i1 %cmp, label %if.then, label %if.end, !dbg !42

if.then:                                          ; preds = %entry
  %call1 = call i32 (ptr, ...) @printf(ptr noundef @.str), !dbg !43
  store i32 1, ptr %retval, align 4, !dbg !45
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup, !dbg !45

if.end:                                           ; preds = %entry
  call void @llvm.lifetime.start.p0(i64 4, ptr %i) #7, !dbg !46
  call void @llvm.dbg.declare(metadata ptr %i, metadata !48, metadata !DIExpression()), !dbg !49
  store i32 0, ptr %i, align 4, !dbg !49
  br label %for.cond, !dbg !46

for.cond:                                         ; preds = %for.inc, %if.end
  %1 = load i32, ptr %i, align 4, !dbg !50
  %cmp2 = icmp slt i32 %1, 4, !dbg !52
  br i1 %cmp2, label %for.body, label %for.cond.cleanup, !dbg !53

for.cond.cleanup:                                 ; preds = %for.cond
  store i32 2, ptr %cleanup.dest.slot, align 4
  call void @llvm.lifetime.end.p0(i64 4, ptr %i) #7, !dbg !54
  br label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, ptr %i, align 4, !dbg !55
  %3 = load ptr, ptr %arr, align 8, !dbg !57
  %4 = load i32, ptr %i, align 4, !dbg !58
  %idxprom = sext i32 %4 to i64, !dbg !57
  %arrayidx = getelementptr inbounds i32, ptr %3, i64 %idxprom, !dbg !57
  %5 = ptrtoint ptr %arrayidx to i64, !dbg !59
  %6 = lshr i64 %5, 3, !dbg !59
  %7 = add i64 %6, 2147450880, !dbg !59
  %8 = inttoptr i64 %7 to ptr, !dbg !59
  %9 = load i8, ptr %8, align 1, !dbg !59
  %10 = icmp ne i8 %9, 0, !dbg !59
  br i1 %10, label %11, label %17, !dbg !59, !prof !60

11:                                               ; preds = %for.body
  %12 = and i64 %5, 7, !dbg !59
  %13 = add i64 %12, 3, !dbg !59
  %14 = trunc i64 %13 to i8, !dbg !59
  %15 = icmp sge i8 %14, %9, !dbg !59
  br i1 %15, label %16, label %17, !dbg !59

16:                                               ; preds = %11
  call void @__asan_report_store4(i64 %5) #9, !dbg !59
  unreachable

17:                                               ; preds = %11, %for.body
  store i32 %2, ptr %arrayidx, align 4, !dbg !59
  br label %for.inc, !dbg !61

for.inc:                                          ; preds = %17
  %18 = load i32, ptr %i, align 4, !dbg !62
  %inc = add nsw i32 %18, 1, !dbg !62
  store i32 %inc, ptr %i, align 4, !dbg !62
  br label %for.cond, !dbg !54, !llvm.loop !63

for.end:                                          ; preds = %for.cond.cleanup
  %19 = load ptr, ptr %arr, align 8, !dbg !66
  %arrayidx3 = getelementptr inbounds i32, ptr %19, i64 0, !dbg !66
  %20 = ptrtoint ptr %arrayidx3 to i64, !dbg !66
  %21 = lshr i64 %20, 3, !dbg !66
  %22 = add i64 %21, 2147450880, !dbg !66
  %23 = inttoptr i64 %22 to ptr, !dbg !66
  %24 = load i8, ptr %23, align 1, !dbg !66
  %25 = icmp ne i8 %24, 0, !dbg !66
  br i1 %25, label %26, label %32, !dbg !66, !prof !60

26:                                               ; preds = %for.end
  %27 = and i64 %20, 7, !dbg !66
  %28 = add i64 %27, 3, !dbg !66
  %29 = trunc i64 %28 to i8, !dbg !66
  %30 = icmp sge i8 %29, %24, !dbg !66
  br i1 %30, label %31, label %32, !dbg !66

31:                                               ; preds = %26
  call void @__asan_report_load4(i64 %20) #9, !dbg !66
  unreachable

32:                                               ; preds = %26, %for.end
  %33 = load i32, ptr %arrayidx3, align 4, !dbg !66
  %call4 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, i32 noundef %33), !dbg !67
  %34 = load ptr, ptr %arr, align 8, !dbg !68
  %arrayidx5 = getelementptr inbounds i32, ptr %34, i64 4, !dbg !68
  %35 = ptrtoint ptr %arrayidx5 to i64, !dbg !69
  %36 = lshr i64 %35, 3, !dbg !69
  %37 = add i64 %36, 2147450880, !dbg !69
  %38 = inttoptr i64 %37 to ptr, !dbg !69
  %39 = load i8, ptr %38, align 1, !dbg !69
  %40 = icmp ne i8 %39, 0, !dbg !69
  br i1 %40, label %41, label %47, !dbg !69, !prof !60

41:                                               ; preds = %32
  %42 = and i64 %35, 7, !dbg !69
  %43 = add i64 %42, 3, !dbg !69
  %44 = trunc i64 %43 to i8, !dbg !69
  %45 = icmp sge i8 %44, %39, !dbg !69
  br i1 %45, label %46, label %47, !dbg !69

46:                                               ; preds = %41
  call void @__asan_report_store4(i64 %35) #9, !dbg !69
  unreachable

47:                                               ; preds = %41, %32
  store i32 100, ptr %arrayidx5, align 4, !dbg !69
  %48 = load ptr, ptr %arr, align 8, !dbg !70
  %arrayidx6 = getelementptr inbounds i32, ptr %48, i64 4, !dbg !70
  %49 = ptrtoint ptr %arrayidx6 to i64, !dbg !70
  %50 = lshr i64 %49, 3, !dbg !70
  %51 = add i64 %50, 2147450880, !dbg !70
  %52 = inttoptr i64 %51 to ptr, !dbg !70
  %53 = load i8, ptr %52, align 1, !dbg !70
  %54 = icmp ne i8 %53, 0, !dbg !70
  br i1 %54, label %55, label %61, !dbg !70, !prof !60

55:                                               ; preds = %47
  %56 = and i64 %49, 7, !dbg !70
  %57 = add i64 %56, 3, !dbg !70
  %58 = trunc i64 %57 to i8, !dbg !70
  %59 = icmp sge i8 %58, %53, !dbg !70
  br i1 %59, label %60, label %61, !dbg !70

60:                                               ; preds = %55
  call void @__asan_report_load4(i64 %49) #9, !dbg !70
  unreachable

61:                                               ; preds = %55, %47
  %62 = load i32, ptr %arrayidx6, align 4, !dbg !70
  %call7 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %62), !dbg !71
  %63 = load ptr, ptr %arr, align 8, !dbg !72
  call void @free(ptr noundef %63) #7, !dbg !73
  store i32 0, ptr %retval, align 4, !dbg !74
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup, !dbg !74

cleanup:                                          ; preds = %61, %if.then
  call void @llvm.lifetime.end.p0(i64 8, ptr %arr) #7, !dbg !75
  %64 = load i32, ptr %retval, align 4, !dbg !75
  ret i32 %64, !dbg !75
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #3

declare i32 @printf(ptr noundef, ...) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nounwind
declare void @free(ptr noundef) #5

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
define internal void @asan.module_ctor() #6 comdat {
  call void @__asan_init()
  call void @__asan_version_mismatch_check_v8()
  call void @__asan_register_elf_globals(i64 ptrtoint (ptr @___asan_globals_registered to i64), i64 ptrtoint (ptr @__start_asan_globals to i64), i64 ptrtoint (ptr @__stop_asan_globals to i64))
  ret void
}

declare void @__asan_version_mismatch_check_v8()

; Function Attrs: nounwind uwtable
define internal void @asan.module_dtor() #6 comdat {
  call void @__asan_unregister_elf_globals(i64 ptrtoint (ptr @___asan_globals_registered to i64), i64 ptrtoint (ptr @__start_asan_globals to i64), i64 ptrtoint (ptr @__stop_asan_globals to i64))
  ret void
}

attributes #0 = { noinline nounwind optnone sanitize_address uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind uwtable "frame-pointer"="all" }
attributes #7 = { nounwind }
attributes #8 = { nounwind allocsize(0) }
attributes #9 = { nomerge }

!llvm.dbg.cu = !{!17}
!llvm.module.flags = !{!23, !24, !25, !26, !27, !28, !29}
!llvm.ident = !{!30}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 15, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "src/basic/heap_oob.c", directory: "/home/user/asan_study", checksumkind: CSK_MD5, checksum: "893c71f7600e348656aae73ba795dfbe")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 120, elements: !5)
!4 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!5 = !{!6}
!6 = !DISubrange(count: 15)
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(scope: null, file: !2, line: 24, type: !9, isLocal: true, isDefinition: true)
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 128, elements: !10)
!10 = !{!11}
!11 = !DISubrange(count: 16)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(scope: null, file: !2, line: 28, type: !3, isLocal: true, isDefinition: true)
!14 = !{ptr @.str}
!15 = !{ptr @.str.1}
!16 = !{ptr @.str.2}
!17 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !18, globals: !22, splitDebugInlining: false, nameTableKind: None)
!18 = !{!19, !21}
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !20, size: 64)
!20 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!21 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!22 = !{!0, !7, !12}
!23 = !{i32 7, !"Dwarf Version", i32 5}
!24 = !{i32 2, !"Debug Info Version", i32 3}
!25 = !{i32 1, !"wchar_size", i32 4}
!26 = !{i32 8, !"PIC Level", i32 2}
!27 = !{i32 7, !"PIE Level", i32 2}
!28 = !{i32 7, !"uwtable", i32 2}
!29 = !{i32 7, !"frame-pointer", i32 2}
!30 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!31 = distinct !DISubprogram(name: "main", scope: !2, file: !2, line: 9, type: !32, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !17, retainedNodes: !34)
!32 = !DISubroutineType(types: !33)
!33 = !{!20}
!34 = !{}
!35 = !DILocation(line: 11, column: 5, scope: !31)
!36 = !DILocalVariable(name: "arr", scope: !31, file: !2, line: 11, type: !19)
!37 = !DILocation(line: 11, column: 10, scope: !31)
!38 = !DILocation(line: 11, column: 22, scope: !31)
!39 = !DILocation(line: 13, column: 9, scope: !40)
!40 = distinct !DILexicalBlock(scope: !31, file: !2, line: 13, column: 9)
!41 = !DILocation(line: 13, column: 13, scope: !40)
!42 = !DILocation(line: 13, column: 9, scope: !31)
!43 = !DILocation(line: 15, column: 9, scope: !44)
!44 = distinct !DILexicalBlock(scope: !40, file: !2, line: 14, column: 5)
!45 = !DILocation(line: 16, column: 9, scope: !44)
!46 = !DILocation(line: 19, column: 10, scope: !47)
!47 = distinct !DILexicalBlock(scope: !31, file: !2, line: 19, column: 5)
!48 = !DILocalVariable(name: "i", scope: !47, file: !2, line: 19, type: !20)
!49 = !DILocation(line: 19, column: 14, scope: !47)
!50 = !DILocation(line: 19, column: 21, scope: !51)
!51 = distinct !DILexicalBlock(scope: !47, file: !2, line: 19, column: 5)
!52 = !DILocation(line: 19, column: 23, scope: !51)
!53 = !DILocation(line: 19, column: 5, scope: !47)
!54 = !DILocation(line: 19, column: 5, scope: !51)
!55 = !DILocation(line: 21, column: 18, scope: !56)
!56 = distinct !DILexicalBlock(scope: !51, file: !2, line: 20, column: 5)
!57 = !DILocation(line: 21, column: 9, scope: !56)
!58 = !DILocation(line: 21, column: 13, scope: !56)
!59 = !DILocation(line: 21, column: 16, scope: !56)
!60 = !{!"branch_weights", i32 1, i32 100000}
!61 = !DILocation(line: 22, column: 5, scope: !56)
!62 = !DILocation(line: 19, column: 29, scope: !51)
!63 = distinct !{!63, !53, !64, !65}
!64 = !DILocation(line: 22, column: 5, scope: !47)
!65 = !{!"llvm.loop.mustprogress"}
!66 = !DILocation(line: 24, column: 32, scope: !31)
!67 = !DILocation(line: 24, column: 5, scope: !31)
!68 = !DILocation(line: 26, column: 5, scope: !31)
!69 = !DILocation(line: 26, column: 12, scope: !31)
!70 = !DILocation(line: 28, column: 31, scope: !31)
!71 = !DILocation(line: 28, column: 5, scope: !31)
!72 = !DILocation(line: 30, column: 10, scope: !31)
!73 = !DILocation(line: 30, column: 5, scope: !31)
!74 = !DILocation(line: 31, column: 5, scope: !31)
!75 = !DILocation(line: 32, column: 1, scope: !31)
