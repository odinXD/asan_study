; ModuleID = 'src/basic/use_after_free.c'
source_filename = "src/basic/use_after_free.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

$asan.module_ctor = comdat any

$asan.module_dtor = comdat any

$.str.21576b91ab9b15712202e1b4a494877f = comdat any

@.str = internal constant { [14 x i8], [18 x i8] } { [14 x i8] c"malloc failed\00", [18 x i8] zeroinitializer }, comdat($.str.21576b91ab9b15712202e1b4a494877f), align 32, !dbg !0
@___asan_gen_ = private constant [27 x i8] c"src/basic/use_after_free.c\00", align 1
@___asan_gen_.1 = private unnamed_addr constant [5 x i8] c".str\00", align 1
@__asan_global_.str = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @0 to i64), i64 14, i64 32, i64 ptrtoint (ptr @___asan_gen_.1 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.21576b91ab9b15712202e1b4a494877f), !associated !7
@llvm.compiler.used = appending global [2 x ptr] [ptr @.str, ptr @__asan_global_.str], section "llvm.metadata"
@___asan_globals_registered = common hidden global i64 0
@__start_asan_globals = extern_weak hidden global i64
@__stop_asan_globals = extern_weak hidden global i64
@llvm.used = appending global [2 x ptr] [ptr @asan.module_ctor, ptr @asan.module_dtor], section "llvm.metadata"
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 1, ptr @asan.module_ctor, ptr @asan.module_ctor }]
@llvm.global_dtors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 1, ptr @asan.module_dtor, ptr @asan.module_dtor }]

@0 = private alias { [14 x i8], [18 x i8] }, ptr @.str

; Function Attrs: noinline nounwind optnone sanitize_address uwtable
define dso_local i32 @main() #0 !dbg !22 {
entry:
  %retval = alloca i32, align 4
  %buffer = alloca ptr, align 8
  %cleanup.dest.slot = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr %buffer) #7, !dbg !26
  call void @llvm.dbg.declare(metadata ptr %buffer, metadata !27, metadata !DIExpression()), !dbg !28
  %call = call noalias ptr @malloc(i64 noundef 16) #8, !dbg !29
  store ptr %call, ptr %buffer, align 8, !dbg !28
  %0 = load ptr, ptr %buffer, align 8, !dbg !30
  %cmp = icmp eq ptr %0, null, !dbg !32
  br i1 %cmp, label %if.then, label %if.end, !dbg !33

if.then:                                          ; preds = %entry
  call void @perror(ptr noundef @.str) #9, !dbg !34
  store i32 1, ptr %retval, align 4, !dbg !36
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup, !dbg !36

if.end:                                           ; preds = %entry
  %1 = load ptr, ptr %buffer, align 8, !dbg !37
  %arrayidx = getelementptr inbounds i32, ptr %1, i64 0, !dbg !37
  %2 = ptrtoint ptr %arrayidx to i64, !dbg !38
  %3 = lshr i64 %2, 3, !dbg !38
  %4 = add i64 %3, 2147450880, !dbg !38
  %5 = inttoptr i64 %4 to ptr, !dbg !38
  %6 = load i8, ptr %5, align 1, !dbg !38
  %7 = icmp ne i8 %6, 0, !dbg !38
  br i1 %7, label %8, label %14, !dbg !38, !prof !39

8:                                                ; preds = %if.end
  %9 = and i64 %2, 7, !dbg !38
  %10 = add i64 %9, 3, !dbg !38
  %11 = trunc i64 %10 to i8, !dbg !38
  %12 = icmp sge i8 %11, %6, !dbg !38
  br i1 %12, label %13, label %14, !dbg !38

13:                                               ; preds = %8
  call void @__asan_report_store4(i64 %2) #10, !dbg !38
  unreachable

14:                                               ; preds = %8, %if.end
  store i32 10, ptr %arrayidx, align 4, !dbg !38
  %15 = load ptr, ptr %buffer, align 8, !dbg !40
  %arrayidx1 = getelementptr inbounds i32, ptr %15, i64 1, !dbg !40
  %16 = ptrtoint ptr %arrayidx1 to i64, !dbg !41
  %17 = lshr i64 %16, 3, !dbg !41
  %18 = add i64 %17, 2147450880, !dbg !41
  %19 = inttoptr i64 %18 to ptr, !dbg !41
  %20 = load i8, ptr %19, align 1, !dbg !41
  %21 = icmp ne i8 %20, 0, !dbg !41
  br i1 %21, label %22, label %28, !dbg !41, !prof !39

22:                                               ; preds = %14
  %23 = and i64 %16, 7, !dbg !41
  %24 = add i64 %23, 3, !dbg !41
  %25 = trunc i64 %24 to i8, !dbg !41
  %26 = icmp sge i8 %25, %20, !dbg !41
  br i1 %26, label %27, label %28, !dbg !41

27:                                               ; preds = %22
  call void @__asan_report_store4(i64 %16) #10, !dbg !41
  unreachable

28:                                               ; preds = %22, %14
  store i32 20, ptr %arrayidx1, align 4, !dbg !41
  %29 = load ptr, ptr %buffer, align 8, !dbg !42
  %arrayidx2 = getelementptr inbounds i32, ptr %29, i64 2, !dbg !42
  %30 = ptrtoint ptr %arrayidx2 to i64, !dbg !43
  %31 = lshr i64 %30, 3, !dbg !43
  %32 = add i64 %31, 2147450880, !dbg !43
  %33 = inttoptr i64 %32 to ptr, !dbg !43
  %34 = load i8, ptr %33, align 1, !dbg !43
  %35 = icmp ne i8 %34, 0, !dbg !43
  br i1 %35, label %36, label %42, !dbg !43, !prof !39

36:                                               ; preds = %28
  %37 = and i64 %30, 7, !dbg !43
  %38 = add i64 %37, 3, !dbg !43
  %39 = trunc i64 %38 to i8, !dbg !43
  %40 = icmp sge i8 %39, %34, !dbg !43
  br i1 %40, label %41, label %42, !dbg !43

41:                                               ; preds = %36
  call void @__asan_report_store4(i64 %30) #10, !dbg !43
  unreachable

42:                                               ; preds = %36, %28
  store i32 30, ptr %arrayidx2, align 4, !dbg !43
  %43 = load ptr, ptr %buffer, align 8, !dbg !44
  %arrayidx3 = getelementptr inbounds i32, ptr %43, i64 3, !dbg !44
  %44 = ptrtoint ptr %arrayidx3 to i64, !dbg !45
  %45 = lshr i64 %44, 3, !dbg !45
  %46 = add i64 %45, 2147450880, !dbg !45
  %47 = inttoptr i64 %46 to ptr, !dbg !45
  %48 = load i8, ptr %47, align 1, !dbg !45
  %49 = icmp ne i8 %48, 0, !dbg !45
  br i1 %49, label %50, label %56, !dbg !45, !prof !39

50:                                               ; preds = %42
  %51 = and i64 %44, 7, !dbg !45
  %52 = add i64 %51, 3, !dbg !45
  %53 = trunc i64 %52 to i8, !dbg !45
  %54 = icmp sge i8 %53, %48, !dbg !45
  br i1 %54, label %55, label %56, !dbg !45

55:                                               ; preds = %50
  call void @__asan_report_store4(i64 %44) #10, !dbg !45
  unreachable

56:                                               ; preds = %50, %42
  store i32 40, ptr %arrayidx3, align 4, !dbg !45
  %57 = load ptr, ptr %buffer, align 8, !dbg !46
  call void @free(ptr noundef %57) #7, !dbg !47
  %58 = load ptr, ptr %buffer, align 8, !dbg !48
  %arrayidx4 = getelementptr inbounds i32, ptr %58, i64 1, !dbg !48
  %59 = ptrtoint ptr %arrayidx4 to i64, !dbg !49
  %60 = lshr i64 %59, 3, !dbg !49
  %61 = add i64 %60, 2147450880, !dbg !49
  %62 = inttoptr i64 %61 to ptr, !dbg !49
  %63 = load i8, ptr %62, align 1, !dbg !49
  %64 = icmp ne i8 %63, 0, !dbg !49
  br i1 %64, label %65, label %71, !dbg !49, !prof !39

65:                                               ; preds = %56
  %66 = and i64 %59, 7, !dbg !49
  %67 = add i64 %66, 3, !dbg !49
  %68 = trunc i64 %67 to i8, !dbg !49
  %69 = icmp sge i8 %68, %63, !dbg !49
  br i1 %69, label %70, label %71, !dbg !49

70:                                               ; preds = %65
  call void @__asan_report_store4(i64 %59) #10, !dbg !49
  unreachable

71:                                               ; preds = %65, %56
  store i32 999, ptr %arrayidx4, align 4, !dbg !49
  store i32 0, ptr %retval, align 4, !dbg !50
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup, !dbg !50

cleanup:                                          ; preds = %71, %if.then
  call void @llvm.lifetime.end.p0(i64 8, ptr %buffer) #7, !dbg !51
  %72 = load i32, ptr %retval, align 4, !dbg !51
  ret i32 %72, !dbg !51
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #3

; Function Attrs: cold
declare void @perror(ptr noundef) #4

; Function Attrs: nounwind
declare void @free(ptr noundef) #5

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
attributes #4 = { cold "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind uwtable "frame-pointer"="all" }
attributes #7 = { nounwind }
attributes #8 = { nounwind allocsize(0) }
attributes #9 = { cold }
attributes #10 = { nomerge }

!llvm.dbg.cu = !{!8}
!llvm.module.flags = !{!14, !15, !16, !17, !18, !19, !20}
!llvm.ident = !{!21}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 14, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "src/basic/use_after_free.c", directory: "/home/user/asan_study", checksumkind: CSK_MD5, checksum: "58a7993daf75c04c2440726c9ae67418")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !5)
!4 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!5 = !{!6}
!6 = !DISubrange(count: 14)
!7 = !{ptr @.str}
!8 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !9, globals: !13, splitDebugInlining: false, nameTableKind: None)
!9 = !{!10, !12}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!13 = !{!0}
!14 = !{i32 7, !"Dwarf Version", i32 5}
!15 = !{i32 2, !"Debug Info Version", i32 3}
!16 = !{i32 1, !"wchar_size", i32 4}
!17 = !{i32 8, !"PIC Level", i32 2}
!18 = !{i32 7, !"PIE Level", i32 2}
!19 = !{i32 7, !"uwtable", i32 2}
!20 = !{i32 7, !"frame-pointer", i32 2}
!21 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!22 = distinct !DISubprogram(name: "main", scope: !2, file: !2, line: 9, type: !23, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !8, retainedNodes: !25)
!23 = !DISubroutineType(types: !24)
!24 = !{!11}
!25 = !{}
!26 = !DILocation(line: 11, column: 5, scope: !22)
!27 = !DILocalVariable(name: "buffer", scope: !22, file: !2, line: 11, type: !10)
!28 = !DILocation(line: 11, column: 10, scope: !22)
!29 = !DILocation(line: 11, column: 26, scope: !22)
!30 = !DILocation(line: 12, column: 9, scope: !31)
!31 = distinct !DILexicalBlock(scope: !22, file: !2, line: 12, column: 9)
!32 = !DILocation(line: 12, column: 16, scope: !31)
!33 = !DILocation(line: 12, column: 9, scope: !22)
!34 = !DILocation(line: 14, column: 9, scope: !35)
!35 = distinct !DILexicalBlock(scope: !31, file: !2, line: 13, column: 5)
!36 = !DILocation(line: 15, column: 9, scope: !35)
!37 = !DILocation(line: 18, column: 5, scope: !22)
!38 = !DILocation(line: 18, column: 15, scope: !22)
!39 = !{!"branch_weights", i32 1, i32 100000}
!40 = !DILocation(line: 19, column: 5, scope: !22)
!41 = !DILocation(line: 19, column: 15, scope: !22)
!42 = !DILocation(line: 20, column: 5, scope: !22)
!43 = !DILocation(line: 20, column: 15, scope: !22)
!44 = !DILocation(line: 21, column: 5, scope: !22)
!45 = !DILocation(line: 21, column: 15, scope: !22)
!46 = !DILocation(line: 23, column: 10, scope: !22)
!47 = !DILocation(line: 23, column: 5, scope: !22)
!48 = !DILocation(line: 25, column: 5, scope: !22)
!49 = !DILocation(line: 25, column: 15, scope: !22)
!50 = !DILocation(line: 27, column: 5, scope: !22)
!51 = !DILocation(line: 28, column: 1, scope: !22)
