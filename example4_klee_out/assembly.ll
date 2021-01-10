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
  call void @llvm.dbg.declare(metadata i32* %3, metadata !16, metadata !DIExpression()), !dbg !17
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
  %19 = icmp sgt i32 %18, 0, !dbg !42
  %20 = load i32, i32* %2, align 4, !dbg !43
  %21 = icmp sgt i32 %20, 0, !dbg !44
  %or.cond = and i1 %19, %21, !dbg !45
  br i1 %or.cond, label %22, label %38, !dbg !45

22:                                               ; preds = %0
  %23 = load i32, i32* %2, align 4, !dbg !46
  %24 = load i32, i32* %5, align 4, !dbg !47
  %25 = icmp slt i32 %23, %24, !dbg !48
  br i1 %25, label %26, label %38, !dbg !49

26:                                               ; preds = %22
  %27 = load i32, i32* %5, align 4, !dbg !50
  %28 = load i32, i32* %3, align 4, !dbg !51
  %29 = icmp sgt i32 %27, %28, !dbg !52
  br i1 %29, label %30, label %38, !dbg !53

30:                                               ; preds = %26
  %31 = load i32, i32* %5, align 4, !dbg !54
  %32 = load i32, i32* %4, align 4, !dbg !55
  %33 = icmp sgt i32 %31, %32, !dbg !56
  br i1 %33, label %34, label %38, !dbg !57

34:                                               ; preds = %30
  %35 = load i32, i32* %3, align 4, !dbg !58
  %36 = load i32, i32* %4, align 4, !dbg !60
  %37 = mul nsw i32 %35, %36, !dbg !61
  store i32 %37, i32* %2, align 4, !dbg !62
  br label %42, !dbg !63

38:                                               ; preds = %30, %26, %22, %0
  %39 = load i32, i32* %3, align 4, !dbg !64
  %40 = load i32, i32* %4, align 4, !dbg !66
  %41 = add nsw i32 %39, %40, !dbg !67
  store i32 %41, i32* %5, align 4, !dbg !68
  br label %42

42:                                               ; preds = %38, %34
  %43 = load i32, i32* %2, align 4, !dbg !69
  %44 = load i32, i32* %5, align 4, !dbg !71
  %45 = icmp sgt i32 %43, %44, !dbg !72
  br i1 %45, label %46, label %47, !dbg !73

46:                                               ; preds = %42
  store i32 0, i32* %3, align 4, !dbg !74
  store i32 0, i32* %4, align 4, !dbg !76
  br label %47, !dbg !77

47:                                               ; preds = %46, %42
  ret i32 0, !dbg !78
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

declare dso_local void @klee_make_symbolic(i8*, i64, i8*) #3

declare dso_local void @klee_make_pse_symbolic(i8*, i64, i8*, float*, float*) #3

; Function Attrs: noinline nounwind uwtable
define dso_local i8* @memcpy(i8* %0, i8* %1, i64 %2) #4 !dbg !79 {
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8*, align 8
  store i8* %0, i8** %4, align 8
  call void @llvm.dbg.declare(metadata i8** %4, metadata !89, metadata !DIExpression()), !dbg !90
  store i8* %1, i8** %5, align 8
  call void @llvm.dbg.declare(metadata i8** %5, metadata !91, metadata !DIExpression()), !dbg !92
  store i64 %2, i64* %6, align 8
  call void @llvm.dbg.declare(metadata i64* %6, metadata !93, metadata !DIExpression()), !dbg !94
  call void @llvm.dbg.declare(metadata i8** %7, metadata !95, metadata !DIExpression()), !dbg !98
  %9 = load i8*, i8** %4, align 8, !dbg !99
  store i8* %9, i8** %7, align 8, !dbg !98
  call void @llvm.dbg.declare(metadata i8** %8, metadata !100, metadata !DIExpression()), !dbg !103
  %10 = load i8*, i8** %5, align 8, !dbg !104
  store i8* %10, i8** %8, align 8, !dbg !103
  br label %11, !dbg !105

11:                                               ; preds = %15, %3
  %12 = load i64, i64* %6, align 8, !dbg !106
  %13 = add i64 %12, -1, !dbg !106
  store i64 %13, i64* %6, align 8, !dbg !106
  %14 = icmp ugt i64 %12, 0, !dbg !107
  br i1 %14, label %15, label %21, !dbg !105

15:                                               ; preds = %11
  %16 = load i8*, i8** %8, align 8, !dbg !108
  %17 = getelementptr inbounds i8, i8* %16, i32 1, !dbg !108
  store i8* %17, i8** %8, align 8, !dbg !108
  %18 = load i8, i8* %16, align 1, !dbg !109
  %19 = load i8*, i8** %7, align 8, !dbg !110
  %20 = getelementptr inbounds i8, i8* %19, i32 1, !dbg !110
  store i8* %20, i8** %7, align 8, !dbg !110
  store i8 %18, i8* %19, align 1, !dbg !111
  br label %11, !dbg !105, !llvm.loop !112

21:                                               ; preds = %11
  %22 = load i8*, i8** %4, align 8, !dbg !113
  ret i8* %22, !dbg !114
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
!17 = !DILocation(line: 10, column: 9, scope: !10)
!18 = !DILocalVariable(name: "b", scope: !10, file: !1, line: 10, type: !13)
!19 = !DILocation(line: 10, column: 12, scope: !10)
!20 = !DILocalVariable(name: "d", scope: !10, file: !1, line: 10, type: !13)
!21 = !DILocation(line: 10, column: 15, scope: !10)
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
!42 = !DILocation(line: 19, column: 8, scope: !41)
!43 = !DILocation(line: 19, column: 15, scope: !41)
!44 = !DILocation(line: 19, column: 17, scope: !41)
!45 = !DILocation(line: 19, column: 12, scope: !41)
!46 = !DILocation(line: 19, column: 24, scope: !41)
!47 = !DILocation(line: 19, column: 28, scope: !41)
!48 = !DILocation(line: 19, column: 26, scope: !41)
!49 = !DILocation(line: 19, column: 30, scope: !41)
!50 = !DILocation(line: 19, column: 33, scope: !41)
!51 = !DILocation(line: 19, column: 37, scope: !41)
!52 = !DILocation(line: 19, column: 35, scope: !41)
!53 = !DILocation(line: 19, column: 39, scope: !41)
!54 = !DILocation(line: 19, column: 42, scope: !41)
!55 = !DILocation(line: 19, column: 46, scope: !41)
!56 = !DILocation(line: 19, column: 44, scope: !41)
!57 = !DILocation(line: 19, column: 6, scope: !10)
!58 = !DILocation(line: 21, column: 7, scope: !59)
!59 = distinct !DILexicalBlock(scope: !41, file: !1, line: 20, column: 2)
!60 = !DILocation(line: 21, column: 11, scope: !59)
!61 = !DILocation(line: 21, column: 9, scope: !59)
!62 = !DILocation(line: 21, column: 5, scope: !59)
!63 = !DILocation(line: 22, column: 2, scope: !59)
!64 = !DILocation(line: 25, column: 7, scope: !65)
!65 = distinct !DILexicalBlock(scope: !41, file: !1, line: 24, column: 2)
!66 = !DILocation(line: 25, column: 11, scope: !65)
!67 = !DILocation(line: 25, column: 9, scope: !65)
!68 = !DILocation(line: 25, column: 5, scope: !65)
!69 = !DILocation(line: 28, column: 6, scope: !70)
!70 = distinct !DILexicalBlock(scope: !10, file: !1, line: 28, column: 6)
!71 = !DILocation(line: 28, column: 10, scope: !70)
!72 = !DILocation(line: 28, column: 8, scope: !70)
!73 = !DILocation(line: 28, column: 6, scope: !10)
!74 = !DILocation(line: 30, column: 5, scope: !75)
!75 = distinct !DILexicalBlock(scope: !70, file: !1, line: 29, column: 2)
!76 = !DILocation(line: 31, column: 5, scope: !75)
!77 = !DILocation(line: 32, column: 2, scope: !75)
!78 = !DILocation(line: 34, column: 2, scope: !10)
!79 = distinct !DISubprogram(name: "memcpy", scope: !80, file: !80, line: 12, type: !81, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !3, retainedNodes: !2)
!80 = !DIFile(filename: "klee/runtime/Freestanding/memcpy.c", directory: "/home/mlc6555")
!81 = !DISubroutineType(types: !82)
!82 = !{!83, !83, !84, !86}
!83 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!84 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !85, size: 64)
!85 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!86 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !87, line: 46, baseType: !88)
!87 = !DIFile(filename: "/usr/lib/llvm-9/lib/clang/9.0.1/include/stddef.h", directory: "")
!88 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!89 = !DILocalVariable(name: "destaddr", arg: 1, scope: !79, file: !80, line: 12, type: !83)
!90 = !DILocation(line: 12, column: 20, scope: !79)
!91 = !DILocalVariable(name: "srcaddr", arg: 2, scope: !79, file: !80, line: 12, type: !84)
!92 = !DILocation(line: 12, column: 42, scope: !79)
!93 = !DILocalVariable(name: "len", arg: 3, scope: !79, file: !80, line: 12, type: !86)
!94 = !DILocation(line: 12, column: 58, scope: !79)
!95 = !DILocalVariable(name: "dest", scope: !79, file: !80, line: 13, type: !96)
!96 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !97, size: 64)
!97 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!98 = !DILocation(line: 13, column: 9, scope: !79)
!99 = !DILocation(line: 13, column: 16, scope: !79)
!100 = !DILocalVariable(name: "src", scope: !79, file: !80, line: 14, type: !101)
!101 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !102, size: 64)
!102 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !97)
!103 = !DILocation(line: 14, column: 15, scope: !79)
!104 = !DILocation(line: 14, column: 21, scope: !79)
!105 = !DILocation(line: 16, column: 3, scope: !79)
!106 = !DILocation(line: 16, column: 13, scope: !79)
!107 = !DILocation(line: 16, column: 16, scope: !79)
!108 = !DILocation(line: 17, column: 19, scope: !79)
!109 = !DILocation(line: 17, column: 15, scope: !79)
!110 = !DILocation(line: 17, column: 10, scope: !79)
!111 = !DILocation(line: 17, column: 13, scope: !79)
!112 = distinct !{!112, !105, !108}
!113 = !DILocation(line: 18, column: 10, scope: !79)
!114 = !DILocation(line: 18, column: 3, scope: !79)
