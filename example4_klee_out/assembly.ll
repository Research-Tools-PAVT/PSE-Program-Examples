; ModuleID = 'example4.bc'
source_filename = "example4.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@__const.main.dist = private unnamed_addr constant [6 x float] [float 1.000000e+00, float 2.000000e+00, float 3.000000e+00, float 4.000000e+00, float 5.000000e+00, float 6.000000e+00], align 16
@__const.main.prob = private unnamed_addr constant [6 x float] [float 0x3FB99999A0000000, float 0x3FD99999A0000000, float 0x3FB99999A0000000, float 0x3FB99999A0000000, float 0x3FC99999A0000000, float 0x3FB99999A0000000], align 16
@.str = private unnamed_addr constant [6 x i8] c"a_sym\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"b_sym\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"c_sym\00", align 1
@.str.3 = private unnamed_addr constant [10 x i8] c"d_pse_sym\00", align 1

; Function Attrs: noinline norecurse uwtable
define dso_local i32 @main() #0 !dbg !10 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca [6 x float], align 16
  %7 = alloca [6 x float], align 16
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !14, metadata !DIExpression()), !dbg !15
  store i32 90, i32* %2, align 4, !dbg !15
  call void @llvm.dbg.declare(metadata i32* %3, metadata !16, metadata !DIExpression()), !dbg !17
  store i32 90, i32* %3, align 4, !dbg !17
  call void @llvm.dbg.declare(metadata i32* %4, metadata !18, metadata !DIExpression()), !dbg !19
  call void @llvm.dbg.declare(metadata i32* %5, metadata !20, metadata !DIExpression()), !dbg !21
  call void @llvm.dbg.declare(metadata [6 x float]* %6, metadata !22, metadata !DIExpression()), !dbg !27
  %8 = bitcast [6 x float]* %6 to i8*, !dbg !27
  %9 = call i8* @memcpy(i8* %8, i8* bitcast ([6 x float]* @__const.main.dist to i8*), i64 24), !dbg !27
  call void @llvm.dbg.declare(metadata [6 x float]* %7, metadata !28, metadata !DIExpression()), !dbg !29
  %10 = bitcast [6 x float]* %7 to i8*, !dbg !29
  %11 = call i8* @memcpy(i8* %10, i8* bitcast ([6 x float]* @__const.main.prob to i8*), i64 24), !dbg !29
  %12 = bitcast i32* %3 to i8*, !dbg !30
  call void @klee_make_symbolic(i8* %12, i64 4, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0)), !dbg !31
  %13 = bitcast i32* %4 to i8*, !dbg !32
  call void @klee_make_symbolic(i8* %13, i64 4, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0)), !dbg !33
  %14 = bitcast i32* %2 to i8*, !dbg !34
  call void @klee_make_symbolic(i8* %14, i64 4, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)), !dbg !35
  %15 = bitcast i32* %5 to i8*, !dbg !36
  %16 = getelementptr inbounds [6 x float], [6 x float]* %6, i64 0, i64 0, !dbg !37
  %17 = getelementptr inbounds [6 x float], [6 x float]* %7, i64 0, i64 0, !dbg !38
  call void @klee_make_pse_symbolic(i8* %15, i64 4, i8* getelementptr inbounds ([10 x i8], [10 x i8]* @.str.3, i64 0, i64 0), float* %16, float* %17), !dbg !39
  %18 = load i32, i32* %3, align 4, !dbg !40
  %19 = load i32, i32* %4, align 4, !dbg !42
  %20 = icmp sgt i32 %18, %19, !dbg !43
  br i1 %20, label %29, label %21, !dbg !44

21:                                               ; preds = %0
  %22 = load i32, i32* %2, align 4, !dbg !45
  %23 = load i32, i32* %5, align 4, !dbg !46
  %24 = icmp sgt i32 %22, %23, !dbg !47
  br i1 %24, label %29, label %25, !dbg !48

25:                                               ; preds = %21
  %26 = load i32, i32* %3, align 4, !dbg !49
  %27 = load i32, i32* %2, align 4, !dbg !50
  %28 = icmp sgt i32 %26, %27, !dbg !51
  br i1 %28, label %29, label %33, !dbg !52

29:                                               ; preds = %25, %21, %0
  %30 = load i32, i32* %2, align 4, !dbg !53
  %31 = load i32, i32* %5, align 4, !dbg !55
  %32 = mul nsw i32 %30, %31, !dbg !56
  store i32 %32, i32* %3, align 4, !dbg !57
  br label %37, !dbg !58

33:                                               ; preds = %25
  %34 = load i32, i32* %2, align 4, !dbg !59
  %35 = load i32, i32* %5, align 4, !dbg !61
  %36 = mul nsw i32 %34, %35, !dbg !62
  store i32 %36, i32* %4, align 4, !dbg !63
  br label %37

37:                                               ; preds = %33, %29
  ret i32 0, !dbg !64
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

declare dso_local void @klee_make_symbolic(i8*, i64, i8*) #3

declare dso_local void @klee_make_pse_symbolic(i8*, i64, i8*, float*, float*) #3

; Function Attrs: noinline nounwind uwtable
define dso_local i8* @memcpy(i8* %0, i8* %1, i64 %2) #4 !dbg !65 {
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8*, align 8
  store i8* %0, i8** %4, align 8
  call void @llvm.dbg.declare(metadata i8** %4, metadata !75, metadata !DIExpression()), !dbg !76
  store i8* %1, i8** %5, align 8
  call void @llvm.dbg.declare(metadata i8** %5, metadata !77, metadata !DIExpression()), !dbg !78
  store i64 %2, i64* %6, align 8
  call void @llvm.dbg.declare(metadata i64* %6, metadata !79, metadata !DIExpression()), !dbg !80
  call void @llvm.dbg.declare(metadata i8** %7, metadata !81, metadata !DIExpression()), !dbg !84
  %9 = load i8*, i8** %4, align 8, !dbg !85
  store i8* %9, i8** %7, align 8, !dbg !84
  call void @llvm.dbg.declare(metadata i8** %8, metadata !86, metadata !DIExpression()), !dbg !89
  %10 = load i8*, i8** %5, align 8, !dbg !90
  store i8* %10, i8** %8, align 8, !dbg !89
  br label %11, !dbg !91

11:                                               ; preds = %15, %3
  %12 = load i64, i64* %6, align 8, !dbg !92
  %13 = add i64 %12, -1, !dbg !92
  store i64 %13, i64* %6, align 8, !dbg !92
  %14 = icmp ugt i64 %12, 0, !dbg !93
  br i1 %14, label %15, label %21, !dbg !91

15:                                               ; preds = %11
  %16 = load i8*, i8** %8, align 8, !dbg !94
  %17 = getelementptr inbounds i8, i8* %16, i32 1, !dbg !94
  store i8* %17, i8** %8, align 8, !dbg !94
  %18 = load i8, i8* %16, align 1, !dbg !95
  %19 = load i8*, i8** %7, align 8, !dbg !96
  %20 = getelementptr inbounds i8, i8* %19, i32 1, !dbg !96
  store i8* %20, i8** %7, align 8, !dbg !96
  store i8 %18, i8* %19, align 1, !dbg !97
  br label %11, !dbg !91, !llvm.loop !98

21:                                               ; preds = %11
  %22 = load i8*, i8** %4, align 8, !dbg !99
  ret i8* %22, !dbg !100
}

attributes #0 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { argmemonly nounwind willreturn }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0, !3}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8, !9}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "example4.cpp", directory: "/home/mlc6555/Documents/Research/PSE-Program-Examples")
!2 = !{}
!3 = distinct !DICompileUnit(language: DW_LANG_C99, file: !4, producer: "clang version 9.0.1-12 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!4 = !DIFile(filename: "/home/mlc6555/klee/runtime/Freestanding/memcpy.c", directory: "/home/mlc6555/klee-build/runtime/Freestanding")
!5 = !{i32 7, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 10.0.0-4ubuntu1 "}
!9 = !{!"clang version 9.0.1-12 "}
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !11, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DILocalVariable(name: "c", scope: !10, file: !1, line: 10, type: !13)
!15 = !DILocation(line: 10, column: 6, scope: !10)
!16 = !DILocalVariable(name: "a", scope: !10, file: !1, line: 10, type: !13)
!17 = !DILocation(line: 10, column: 14, scope: !10)
!18 = !DILocalVariable(name: "b", scope: !10, file: !1, line: 10, type: !13)
!19 = !DILocation(line: 10, column: 22, scope: !10)
!20 = !DILocalVariable(name: "d", scope: !10, file: !1, line: 10, type: !13)
!21 = !DILocation(line: 10, column: 25, scope: !10)
!22 = !DILocalVariable(name: "dist", scope: !10, file: !1, line: 11, type: !23)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !24, size: 192, elements: !25)
!24 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!25 = !{!26}
!26 = !DISubrange(count: 6)
!27 = !DILocation(line: 11, column: 8, scope: !10)
!28 = !DILocalVariable(name: "prob", scope: !10, file: !1, line: 12, type: !23)
!29 = !DILocation(line: 12, column: 8, scope: !10)
!30 = !DILocation(line: 14, column: 21, scope: !10)
!31 = !DILocation(line: 14, column: 2, scope: !10)
!32 = !DILocation(line: 15, column: 21, scope: !10)
!33 = !DILocation(line: 15, column: 2, scope: !10)
!34 = !DILocation(line: 16, column: 21, scope: !10)
!35 = !DILocation(line: 16, column: 2, scope: !10)
!36 = !DILocation(line: 17, column: 25, scope: !10)
!37 = !DILocation(line: 17, column: 53, scope: !10)
!38 = !DILocation(line: 17, column: 59, scope: !10)
!39 = !DILocation(line: 17, column: 2, scope: !10)
!40 = !DILocation(line: 19, column: 6, scope: !41)
!41 = distinct !DILexicalBlock(scope: !10, file: !1, line: 19, column: 6)
!42 = !DILocation(line: 19, column: 10, scope: !41)
!43 = !DILocation(line: 19, column: 8, scope: !41)
!44 = !DILocation(line: 19, column: 12, scope: !41)
!45 = !DILocation(line: 19, column: 15, scope: !41)
!46 = !DILocation(line: 19, column: 19, scope: !41)
!47 = !DILocation(line: 19, column: 17, scope: !41)
!48 = !DILocation(line: 19, column: 21, scope: !41)
!49 = !DILocation(line: 19, column: 24, scope: !41)
!50 = !DILocation(line: 19, column: 28, scope: !41)
!51 = !DILocation(line: 19, column: 26, scope: !41)
!52 = !DILocation(line: 19, column: 6, scope: !10)
!53 = !DILocation(line: 21, column: 7, scope: !54)
!54 = distinct !DILexicalBlock(scope: !41, file: !1, line: 20, column: 2)
!55 = !DILocation(line: 21, column: 11, scope: !54)
!56 = !DILocation(line: 21, column: 9, scope: !54)
!57 = !DILocation(line: 21, column: 5, scope: !54)
!58 = !DILocation(line: 22, column: 2, scope: !54)
!59 = !DILocation(line: 25, column: 7, scope: !60)
!60 = distinct !DILexicalBlock(scope: !41, file: !1, line: 24, column: 2)
!61 = !DILocation(line: 25, column: 11, scope: !60)
!62 = !DILocation(line: 25, column: 9, scope: !60)
!63 = !DILocation(line: 25, column: 5, scope: !60)
!64 = !DILocation(line: 28, column: 2, scope: !10)
!65 = distinct !DISubprogram(name: "memcpy", scope: !66, file: !66, line: 12, type: !67, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !3, retainedNodes: !2)
!66 = !DIFile(filename: "klee/runtime/Freestanding/memcpy.c", directory: "/home/mlc6555")
!67 = !DISubroutineType(types: !68)
!68 = !{!69, !69, !70, !72}
!69 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!70 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !71, size: 64)
!71 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!72 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !73, line: 46, baseType: !74)
!73 = !DIFile(filename: "/usr/lib/llvm-9/lib/clang/9.0.1/include/stddef.h", directory: "")
!74 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!75 = !DILocalVariable(name: "destaddr", arg: 1, scope: !65, file: !66, line: 12, type: !69)
!76 = !DILocation(line: 12, column: 20, scope: !65)
!77 = !DILocalVariable(name: "srcaddr", arg: 2, scope: !65, file: !66, line: 12, type: !70)
!78 = !DILocation(line: 12, column: 42, scope: !65)
!79 = !DILocalVariable(name: "len", arg: 3, scope: !65, file: !66, line: 12, type: !72)
!80 = !DILocation(line: 12, column: 58, scope: !65)
!81 = !DILocalVariable(name: "dest", scope: !65, file: !66, line: 13, type: !82)
!82 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !83, size: 64)
!83 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!84 = !DILocation(line: 13, column: 9, scope: !65)
!85 = !DILocation(line: 13, column: 16, scope: !65)
!86 = !DILocalVariable(name: "src", scope: !65, file: !66, line: 14, type: !87)
!87 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !88, size: 64)
!88 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !83)
!89 = !DILocation(line: 14, column: 15, scope: !65)
!90 = !DILocation(line: 14, column: 21, scope: !65)
!91 = !DILocation(line: 16, column: 3, scope: !65)
!92 = !DILocation(line: 16, column: 13, scope: !65)
!93 = !DILocation(line: 16, column: 16, scope: !65)
!94 = !DILocation(line: 17, column: 19, scope: !65)
!95 = !DILocation(line: 17, column: 15, scope: !65)
!96 = !DILocation(line: 17, column: 10, scope: !65)
!97 = !DILocation(line: 17, column: 13, scope: !65)
!98 = distinct !{!98, !91, !94}
!99 = !DILocation(line: 18, column: 10, scope: !65)
!100 = !DILocation(line: 18, column: 3, scope: !65)
