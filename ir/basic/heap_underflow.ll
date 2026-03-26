; ModuleID = 'src/basic/heap_underflow.c'
source_filename = "src/basic/heap_underflow.c"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

$asan.module_ctor = comdat any

$asan.module_dtor = comdat any

$.str.21576b91ab9b15712202e1b4a494877f = comdat any

$.str.1.21576b91ab9b15712202e1b4a494877f = comdat any

$.str.2.21576b91ab9b15712202e1b4a494877f = comdat any

$.str.3.21576b91ab9b15712202e1b4a494877f = comdat any

@.str = internal constant { [14 x i8], [18 x i8] } { [14 x i8] c"malloc failed\00", [18 x i8] zeroinitializer }, comdat($.str.21576b91ab9b15712202e1b4a494877f), align 32, !dbg !0
@.str.1 = internal constant { [20 x i8], [44 x i8] } { [20 x i8] c"buffer address: %p\0A\00", [44 x i8] zeroinitializer }, comdat($.str.1.21576b91ab9b15712202e1b4a494877f), align 32, !dbg !7
@.str.2 = internal constant { [36 x i8], [60 x i8] } { [36 x i8] c"buffer[0] before invalid write: %d\0A\00", [60 x i8] zeroinitializer }, comdat($.str.2.21576b91ab9b15712202e1b4a494877f), align 32, !dbg !12
@.str.3 = internal constant { [34 x i8], [62 x i8] } { [34 x i8] c"this line may not be reached: %d\0A\00", [62 x i8] zeroinitializer }, comdat($.str.3.21576b91ab9b15712202e1b4a494877f), align 32, !dbg !17
@___asan_gen_ = private constant [27 x i8] c"src/basic/heap_underflow.c\00", align 1
@___asan_gen_.4 = private unnamed_addr constant [5 x i8] c".str\00", align 1
@___asan_gen_.5 = private unnamed_addr constant [7 x i8] c".str.1\00", align 1
@___asan_gen_.6 = private unnamed_addr constant [7 x i8] c".str.2\00", align 1
@___asan_gen_.7 = private unnamed_addr constant [7 x i8] c".str.3\00", align 1
@__asan_global_.str = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @0 to i64), i64 14, i64 32, i64 ptrtoint (ptr @___asan_gen_.4 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.21576b91ab9b15712202e1b4a494877f), !associated !22
@__asan_global_.str.1 = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @1 to i64), i64 20, i64 64, i64 ptrtoint (ptr @___asan_gen_.5 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.1.21576b91ab9b15712202e1b4a494877f), !associated !23
@__asan_global_.str.2 = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @2 to i64), i64 36, i64 96, i64 ptrtoint (ptr @___asan_gen_.6 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.2.21576b91ab9b15712202e1b4a494877f), !associated !24
@__asan_global_.str.3 = private global { i64, i64, i64, i64, i64, i64, i64, i64 } { i64 ptrtoint (ptr @3 to i64), i64 34, i64 96, i64 ptrtoint (ptr @___asan_gen_.7 to i64), i64 ptrtoint (ptr @___asan_gen_ to i64), i64 0, i64 0, i64 -1 }, section "asan_globals", comdat($.str.3.21576b91ab9b15712202e1b4a494877f), !associated !25
@llvm.compiler.used = appending global [8 x ptr] [ptr @.str, ptr @.str.1, ptr @.str.2, ptr @.str.3, ptr @__asan_global_.str, ptr @__asan_global_.str.1, ptr @__asan_global_.str.2, ptr @__asan_global_.str.3], section "llvm.metadata"
@___asan_globals_registered = common hidden global i64 0
@__start_asan_globals = extern_weak hidden global i64
@__stop_asan_globals = extern_weak hidden global i64
@llvm.used = appending global [2 x ptr] [ptr @asan.module_ctor, ptr @asan.module_dtor], section "llvm.metadata"
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 1, ptr @asan.module_ctor, ptr @asan.module_ctor }]
@llvm.global_dtors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 1, ptr @asan.module_dtor, ptr @asan.module_dtor }]

@0 = private alias { [14 x i8], [18 x i8] }, ptr @.str
@1 = private alias { [20 x i8], [44 x i8] }, ptr @.str.1
@2 = private alias { [36 x i8], [60 x i8] }, ptr @.str.2
@3 = private alias { [34 x i8], [62 x i8] }, ptr @.str.3

; Function Attrs: noinline nounwind optnone sanitize_address uwtable
define dso_local i32 @main() #0 !dbg !40 {
entry:
  %retval = alloca i32, align 4
  %buffer = alloca ptr, align 8
  %cleanup.dest.slot = alloca i32, align 4
  %index = alloca i32, align 4
  store i32 0, ptr %retval, align 4
  call void @llvm.lifetime.start.p0(i64 8, ptr %buffer) #8, !dbg !44
  call void @llvm.dbg.declare(metadata ptr %buffer, metadata !45, metadata !DIExpression()), !dbg !46
  %call = call noalias ptr @malloc(i64 noundef 16) #9, !dbg !47
  store ptr %call, ptr %buffer, align 8, !dbg !46
  %0 = load ptr, ptr %buffer, align 8, !dbg !48
  %cmp = icmp eq ptr %0, null, !dbg !50
  br i1 %cmp, label %if.then, label %if.end, !dbg !51

if.then:                                          ; preds = %entry
  call void @perror(ptr noundef @.str) #10, !dbg !52
  store i32 1, ptr %retval, align 4, !dbg !54
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup, !dbg !54

if.end:                                           ; preds = %entry
  call void @llvm.lifetime.start.p0(i64 4, ptr %index) #8, !dbg !55
  call void @llvm.dbg.declare(metadata ptr %index, metadata !57, metadata !DIExpression()), !dbg !58
  store i32 0, ptr %index, align 4, !dbg !58
  br label %for.cond, !dbg !55

for.cond:                                         ; preds = %for.inc, %if.end
  %1 = load i32, ptr %index, align 4, !dbg !59
  %cmp1 = icmp slt i32 %1, 4, !dbg !61
  br i1 %cmp1, label %for.body, label %for.cond.cleanup, !dbg !62

for.cond.cleanup:                                 ; preds = %for.cond
  store i32 2, ptr %cleanup.dest.slot, align 4
  call void @llvm.lifetime.end.p0(i64 4, ptr %index) #8, !dbg !63
  br label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, ptr %index, align 4, !dbg !64
  %add = add nsw i32 %2, 1, !dbg !66
  %3 = load ptr, ptr %buffer, align 8, !dbg !67
  %4 = load i32, ptr %index, align 4, !dbg !68
  %idxprom = sext i32 %4 to i64, !dbg !67
  %arrayidx = getelementptr inbounds i32, ptr %3, i64 %idxprom, !dbg !67
  %5 = ptrtoint ptr %arrayidx to i64, !dbg !69
  %6 = lshr i64 %5, 3, !dbg !69
  %7 = add i64 %6, 2147450880, !dbg !69
  %8 = inttoptr i64 %7 to ptr, !dbg !69
  %9 = load i8, ptr %8, align 1, !dbg !69
  %10 = icmp ne i8 %9, 0, !dbg !69
  br i1 %10, label %11, label %17, !dbg !69, !prof !70

11:                                               ; preds = %for.body
  %12 = and i64 %5, 7, !dbg !69
  %13 = add i64 %12, 3, !dbg !69
  %14 = trunc i64 %13 to i8, !dbg !69
  %15 = icmp sge i8 %14, %9, !dbg !69
  br i1 %15, label %16, label %17, !dbg !69

16:                                               ; preds = %11
  call void @__asan_report_store4(i64 %5) #11, !dbg !69
  unreachable

17:                                               ; preds = %11, %for.body
  store i32 %add, ptr %arrayidx, align 4, !dbg !69
  br label %for.inc, !dbg !71

for.inc:                                          ; preds = %17
  %18 = load i32, ptr %index, align 4, !dbg !72
  %inc = add nsw i32 %18, 1, !dbg !72
  store i32 %inc, ptr %index, align 4, !dbg !72
  br label %for.cond, !dbg !63, !llvm.loop !73

for.end:                                          ; preds = %for.cond.cleanup
  %19 = load ptr, ptr %buffer, align 8, !dbg !76
  %call2 = call i32 (ptr, ...) @printf(ptr noundef @.str.1, ptr noundef %19), !dbg !77
  %20 = load ptr, ptr %buffer, align 8, !dbg !78
  %arrayidx3 = getelementptr inbounds i32, ptr %20, i64 0, !dbg !78
  %21 = ptrtoint ptr %arrayidx3 to i64, !dbg !78
  %22 = lshr i64 %21, 3, !dbg !78
  %23 = add i64 %22, 2147450880, !dbg !78
  %24 = inttoptr i64 %23 to ptr, !dbg !78
  %25 = load i8, ptr %24, align 1, !dbg !78
  %26 = icmp ne i8 %25, 0, !dbg !78
  br i1 %26, label %27, label %33, !dbg !78, !prof !70

27:                                               ; preds = %for.end
  %28 = and i64 %21, 7, !dbg !78
  %29 = add i64 %28, 3, !dbg !78
  %30 = trunc i64 %29 to i8, !dbg !78
  %31 = icmp sge i8 %30, %25, !dbg !78
  br i1 %31, label %32, label %33, !dbg !78

32:                                               ; preds = %27
  call void @__asan_report_load4(i64 %21) #11, !dbg !78
  unreachable

33:                                               ; preds = %27, %for.end
  %34 = load i32, ptr %arrayidx3, align 4, !dbg !78
  %call4 = call i32 (ptr, ...) @printf(ptr noundef @.str.2, i32 noundef %34), !dbg !79
  %35 = load ptr, ptr %buffer, align 8, !dbg !80
  %arrayidx5 = getelementptr inbounds i32, ptr %35, i64 -1, !dbg !80
  %36 = ptrtoint ptr %arrayidx5 to i64, !dbg !81
  %37 = lshr i64 %36, 3, !dbg !81
  %38 = add i64 %37, 2147450880, !dbg !81
  %39 = inttoptr i64 %38 to ptr, !dbg !81
  %40 = load i8, ptr %39, align 1, !dbg !81
  %41 = icmp ne i8 %40, 0, !dbg !81
  br i1 %41, label %42, label %48, !dbg !81, !prof !70

42:                                               ; preds = %33
  %43 = and i64 %36, 7, !dbg !81
  %44 = add i64 %43, 3, !dbg !81
  %45 = trunc i64 %44 to i8, !dbg !81
  %46 = icmp sge i8 %45, %40, !dbg !81
  br i1 %46, label %47, label %48, !dbg !81

47:                                               ; preds = %42
  call void @__asan_report_store4(i64 %36) #11, !dbg !81
  unreachable

48:                                               ; preds = %42, %33
  store i32 999, ptr %arrayidx5, align 4, !dbg !81
  %49 = load ptr, ptr %buffer, align 8, !dbg !82
  %arrayidx6 = getelementptr inbounds i32, ptr %49, i64 0, !dbg !82
  %50 = ptrtoint ptr %arrayidx6 to i64, !dbg !82
  %51 = lshr i64 %50, 3, !dbg !82
  %52 = add i64 %51, 2147450880, !dbg !82
  %53 = inttoptr i64 %52 to ptr, !dbg !82
  %54 = load i8, ptr %53, align 1, !dbg !82
  %55 = icmp ne i8 %54, 0, !dbg !82
  br i1 %55, label %56, label %62, !dbg !82, !prof !70

56:                                               ; preds = %48
  %57 = and i64 %50, 7, !dbg !82
  %58 = add i64 %57, 3, !dbg !82
  %59 = trunc i64 %58 to i8, !dbg !82
  %60 = icmp sge i8 %59, %54, !dbg !82
  br i1 %60, label %61, label %62, !dbg !82

61:                                               ; preds = %56
  call void @__asan_report_load4(i64 %50) #11, !dbg !82
  unreachable

62:                                               ; preds = %56, %48
  %63 = load i32, ptr %arrayidx6, align 4, !dbg !82
  %call7 = call i32 (ptr, ...) @printf(ptr noundef @.str.3, i32 noundef %63), !dbg !83
  %64 = load ptr, ptr %buffer, align 8, !dbg !84
  call void @free(ptr noundef %64) #8, !dbg !85
  store i32 0, ptr %retval, align 4, !dbg !86
  store i32 1, ptr %cleanup.dest.slot, align 4
  br label %cleanup, !dbg !86

cleanup:                                          ; preds = %62, %if.then
  call void @llvm.lifetime.end.p0(i64 8, ptr %buffer) #8, !dbg !87
  %65 = load i32, ptr %retval, align 4, !dbg !87
  ret i32 %65, !dbg !87
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0(i64 immarg, ptr nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #2

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #3

; Function Attrs: cold
declare void @perror(ptr noundef) #4

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0(i64 immarg, ptr nocapture) #1

declare i32 @printf(ptr noundef, ...) #5

; Function Attrs: nounwind
declare void @free(ptr noundef) #6

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
define internal void @asan.module_ctor() #7 comdat {
  call void @__asan_init()
  call void @__asan_version_mismatch_check_v8()
  call void @__asan_register_elf_globals(i64 ptrtoint (ptr @___asan_globals_registered to i64), i64 ptrtoint (ptr @__start_asan_globals to i64), i64 ptrtoint (ptr @__stop_asan_globals to i64))
  ret void
}

declare void @__asan_version_mismatch_check_v8()

; Function Attrs: nounwind uwtable
define internal void @asan.module_dtor() #7 comdat {
  call void @__asan_unregister_elf_globals(i64 ptrtoint (ptr @___asan_globals_registered to i64), i64 ptrtoint (ptr @__start_asan_globals to i64), i64 ptrtoint (ptr @__stop_asan_globals to i64))
  ret void
}

attributes #0 = { noinline nounwind optnone sanitize_address uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { cold "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { nounwind uwtable "frame-pointer"="all" }
attributes #8 = { nounwind }
attributes #9 = { nounwind allocsize(0) }
attributes #10 = { cold }
attributes #11 = { nomerge }

!llvm.dbg.cu = !{!26}
!llvm.module.flags = !{!32, !33, !34, !35, !36, !37, !38}
!llvm.ident = !{!39}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(scope: null, file: !2, line: 14, type: !3, isLocal: true, isDefinition: true)
!2 = !DIFile(filename: "src/basic/heap_underflow.c", directory: "/home/user/asan_study", checksumkind: CSK_MD5, checksum: "2264645391e891a21865b1c8ef34b8f7")
!3 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 112, elements: !5)
!4 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!5 = !{!6}
!6 = !DISubrange(count: 14)
!7 = !DIGlobalVariableExpression(var: !8, expr: !DIExpression())
!8 = distinct !DIGlobalVariable(scope: null, file: !2, line: 23, type: !9, isLocal: true, isDefinition: true)
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 160, elements: !10)
!10 = !{!11}
!11 = !DISubrange(count: 20)
!12 = !DIGlobalVariableExpression(var: !13, expr: !DIExpression())
!13 = distinct !DIGlobalVariable(scope: null, file: !2, line: 24, type: !14, isLocal: true, isDefinition: true)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 288, elements: !15)
!15 = !{!16}
!16 = !DISubrange(count: 36)
!17 = !DIGlobalVariableExpression(var: !18, expr: !DIExpression())
!18 = distinct !DIGlobalVariable(scope: null, file: !2, line: 28, type: !19, isLocal: true, isDefinition: true)
!19 = !DICompositeType(tag: DW_TAG_array_type, baseType: !4, size: 272, elements: !20)
!20 = !{!21}
!21 = !DISubrange(count: 34)
!22 = !{ptr @.str}
!23 = !{ptr @.str.1}
!24 = !{ptr @.str.2}
!25 = !{ptr @.str.3}
!26 = distinct !DICompileUnit(language: DW_LANG_C11, file: !2, producer: "Ubuntu clang version 18.1.3 (1ubuntu1)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !27, globals: !31, splitDebugInlining: false, nameTableKind: None)
!27 = !{!28, !30}
!28 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !29, size: 64)
!29 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!30 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!31 = !{!0, !7, !12, !17}
!32 = !{i32 7, !"Dwarf Version", i32 5}
!33 = !{i32 2, !"Debug Info Version", i32 3}
!34 = !{i32 1, !"wchar_size", i32 4}
!35 = !{i32 8, !"PIC Level", i32 2}
!36 = !{i32 7, !"PIE Level", i32 2}
!37 = !{i32 7, !"uwtable", i32 2}
!38 = !{i32 7, !"frame-pointer", i32 2}
!39 = !{!"Ubuntu clang version 18.1.3 (1ubuntu1)"}
!40 = distinct !DISubprogram(name: "main", scope: !2, file: !2, line: 9, type: !41, scopeLine: 10, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !26, retainedNodes: !43)
!41 = !DISubroutineType(types: !42)
!42 = !{!29}
!43 = !{}
!44 = !DILocation(line: 11, column: 5, scope: !40)
!45 = !DILocalVariable(name: "buffer", scope: !40, file: !2, line: 11, type: !28)
!46 = !DILocation(line: 11, column: 10, scope: !40)
!47 = !DILocation(line: 11, column: 26, scope: !40)
!48 = !DILocation(line: 12, column: 9, scope: !49)
!49 = distinct !DILexicalBlock(scope: !40, file: !2, line: 12, column: 9)
!50 = !DILocation(line: 12, column: 16, scope: !49)
!51 = !DILocation(line: 12, column: 9, scope: !40)
!52 = !DILocation(line: 14, column: 9, scope: !53)
!53 = distinct !DILexicalBlock(scope: !49, file: !2, line: 13, column: 5)
!54 = !DILocation(line: 15, column: 9, scope: !53)
!55 = !DILocation(line: 18, column: 10, scope: !56)
!56 = distinct !DILexicalBlock(scope: !40, file: !2, line: 18, column: 5)
!57 = !DILocalVariable(name: "index", scope: !56, file: !2, line: 18, type: !29)
!58 = !DILocation(line: 18, column: 14, scope: !56)
!59 = !DILocation(line: 18, column: 25, scope: !60)
!60 = distinct !DILexicalBlock(scope: !56, file: !2, line: 18, column: 5)
!61 = !DILocation(line: 18, column: 31, scope: !60)
!62 = !DILocation(line: 18, column: 5, scope: !56)
!63 = !DILocation(line: 18, column: 5, scope: !60)
!64 = !DILocation(line: 20, column: 25, scope: !65)
!65 = distinct !DILexicalBlock(scope: !60, file: !2, line: 19, column: 5)
!66 = !DILocation(line: 20, column: 31, scope: !65)
!67 = !DILocation(line: 20, column: 9, scope: !65)
!68 = !DILocation(line: 20, column: 16, scope: !65)
!69 = !DILocation(line: 20, column: 23, scope: !65)
!70 = !{!"branch_weights", i32 1, i32 100000}
!71 = !DILocation(line: 21, column: 5, scope: !65)
!72 = !DILocation(line: 18, column: 41, scope: !60)
!73 = distinct !{!73, !62, !74, !75}
!74 = !DILocation(line: 21, column: 5, scope: !56)
!75 = !{!"llvm.loop.mustprogress"}
!76 = !DILocation(line: 23, column: 44, scope: !40)
!77 = !DILocation(line: 23, column: 5, scope: !40)
!78 = !DILocation(line: 24, column: 52, scope: !40)
!79 = !DILocation(line: 24, column: 5, scope: !40)
!80 = !DILocation(line: 26, column: 5, scope: !40)
!81 = !DILocation(line: 26, column: 16, scope: !40)
!82 = !DILocation(line: 28, column: 50, scope: !40)
!83 = !DILocation(line: 28, column: 5, scope: !40)
!84 = !DILocation(line: 30, column: 10, scope: !40)
!85 = !DILocation(line: 30, column: 5, scope: !40)
!86 = !DILocation(line: 31, column: 5, scope: !40)
!87 = !DILocation(line: 32, column: 1, scope: !40)
