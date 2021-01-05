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
@.str.4 = private unnamed_addr constant [3 x i8] c"%d\00", align 1

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
  br i1 %20, label %21, label %36, !dbg !44

21:                                               ; preds = %0
  %22 = load i32, i32* %5, align 4, !dbg !45
  %23 = load i32, i32* %3, align 4, !dbg !46
  %24 = icmp slt i32 %22, %23, !dbg !47
  br i1 %24, label %25, label %36, !dbg !48

25:                                               ; preds = %21
  %26 = load i32, i32* %2, align 4, !dbg !49
  %27 = load i32, i32* %3, align 4, !dbg !50
  %28 = icmp sgt i32 %26, %27, !dbg !51
  br i1 %28, label %29, label %36, !dbg !52

29:                                               ; preds = %25
  %30 = load i32, i32* %5, align 4, !dbg !53
  %31 = load i32, i32* %4, align 4, !dbg !54
  %32 = icmp slt i32 %30, %31, !dbg !55
  br i1 %32, label %33, label %36, !dbg !56

33:                                               ; preds = %29
  %34 = load i32, i32* %2, align 4, !dbg !57
  %35 = mul nsw i32 %34, 2, !dbg !57
  store i32 %35, i32* %2, align 4, !dbg !57
  br label %45, !dbg !59

36:                                               ; preds = %29, %25, %21, %0
  %37 = load i32, i32* %2, align 4, !dbg !60
  %38 = icmp sgt i32 %37, 0, !dbg !63
  br i1 %38, label %39, label %42, !dbg !64

39:                                               ; preds = %36
  %40 = load i32, i32* %4, align 4, !dbg !65
  %41 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i64 0, i64 0), i32 %40), !dbg !67
  br label %45, !dbg !68

42:                                               ; preds = %36
  %43 = load i32, i32* %5, align 4, !dbg !69
  %44 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.4, i64 0, i64 0), i32 %43), !dbg !71
  br label %45

45:                                               ; preds = %39, %42, %33
  %46 = load i32, i32* %3, align 4, !dbg !72
  %47 = load i32, i32* %2, align 4, !dbg !74
  %48 = icmp sgt i32 %46, %47, !dbg !75
  br i1 %48, label %49, label %54, !dbg !76

49:                                               ; preds = %45
  %50 = load i32, i32* %4, align 4, !dbg !77
  %51 = mul nsw i32 %50, 8, !dbg !77
  store i32 %51, i32* %4, align 4, !dbg !77
  %52 = load i32, i32* %2, align 4, !dbg !79
  %53 = mul nsw i32 %52, 2, !dbg !79
  store i32 %53, i32* %2, align 4, !dbg !79
  br label %61, !dbg !80

54:                                               ; preds = %45
  %55 = load i32, i32* %3, align 4, !dbg !81
  %56 = mul nsw i32 %55, 2, !dbg !81
  store i32 %56, i32* %3, align 4, !dbg !81
  %57 = load i32, i32* %4, align 4, !dbg !83
  %58 = mul nsw i32 %57, 3, !dbg !83
  store i32 %58, i32* %4, align 4, !dbg !83
  %59 = load i32, i32* %2, align 4, !dbg !84
  %60 = mul nsw i32 %59, 4, !dbg !84
  store i32 %60, i32* %2, align 4, !dbg !84
  br label %61

61:                                               ; preds = %54, %49
  ret i32 0, !dbg !85
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind willreturn
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* noalias nocapture writeonly, i8* noalias nocapture readonly, i64, i1 immarg) #2

declare dso_local void @klee_make_symbolic(i8*, i64, i8*) #3

declare dso_local void @klee_make_pse_symbolic(i8*, i64, i8*, float*, float*) #3

declare dso_local i32 @printf(i8*, ...) #3

; Function Attrs: noinline nounwind uwtable
define dso_local i8* @memcpy(i8* %0, i8* %1, i64 %2) #4 !dbg !86 {
  %4 = alloca i8*, align 8
  %5 = alloca i8*, align 8
  %6 = alloca i64, align 8
  %7 = alloca i8*, align 8
  %8 = alloca i8*, align 8
  store i8* %0, i8** %4, align 8
  call void @llvm.dbg.declare(metadata i8** %4, metadata !96, metadata !DIExpression()), !dbg !97
  store i8* %1, i8** %5, align 8
  call void @llvm.dbg.declare(metadata i8** %5, metadata !98, metadata !DIExpression()), !dbg !99
  store i64 %2, i64* %6, align 8
  call void @llvm.dbg.declare(metadata i64* %6, metadata !100, metadata !DIExpression()), !dbg !101
  call void @llvm.dbg.declare(metadata i8** %7, metadata !102, metadata !DIExpression()), !dbg !105
  %9 = load i8*, i8** %4, align 8, !dbg !106
  store i8* %9, i8** %7, align 8, !dbg !105
  call void @llvm.dbg.declare(metadata i8** %8, metadata !107, metadata !DIExpression()), !dbg !110
  %10 = load i8*, i8** %5, align 8, !dbg !111
  store i8* %10, i8** %8, align 8, !dbg !110
  br label %11, !dbg !112

11:                                               ; preds = %15, %3
  %12 = load i64, i64* %6, align 8, !dbg !113
  %13 = add i64 %12, -1, !dbg !113
  store i64 %13, i64* %6, align 8, !dbg !113
  %14 = icmp ugt i64 %12, 0, !dbg !114
  br i1 %14, label %15, label %21, !dbg !112

15:                                               ; preds = %11
  %16 = load i8*, i8** %8, align 8, !dbg !115
  %17 = getelementptr inbounds i8, i8* %16, i32 1, !dbg !115
  store i8* %17, i8** %8, align 8, !dbg !115
  %18 = load i8, i8* %16, align 1, !dbg !116
  %19 = load i8*, i8** %7, align 8, !dbg !117
  %20 = getelementptr inbounds i8, i8* %19, i32 1, !dbg !117
  store i8* %20, i8** %7, align 8, !dbg !117
  store i8 %18, i8* %19, align 1, !dbg !118
  br label %11, !dbg !112, !llvm.loop !119

21:                                               ; preds = %11
  %22 = load i8*, i8** %4, align 8, !dbg !120
  ret i8* %22, !dbg !121
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
!10 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 4, type: !11, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!11 = !DISubroutineType(types: !12)
!12 = !{!13}
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DILocalVariable(name: "c", scope: !10, file: !1, line: 6, type: !13)
!15 = !DILocation(line: 6, column: 6, scope: !10)
!16 = !DILocalVariable(name: "a", scope: !10, file: !1, line: 6, type: !13)
!17 = !DILocation(line: 6, column: 14, scope: !10)
!18 = !DILocalVariable(name: "b", scope: !10, file: !1, line: 6, type: !13)
!19 = !DILocation(line: 6, column: 22, scope: !10)
!20 = !DILocalVariable(name: "d", scope: !10, file: !1, line: 6, type: !13)
!21 = !DILocation(line: 6, column: 25, scope: !10)
!22 = !DILocalVariable(name: "dist", scope: !10, file: !1, line: 7, type: !23)
!23 = !DICompositeType(tag: DW_TAG_array_type, baseType: !24, size: 192, elements: !25)
!24 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!25 = !{!26}
!26 = !DISubrange(count: 6)
!27 = !DILocation(line: 7, column: 8, scope: !10)
!28 = !DILocalVariable(name: "prob", scope: !10, file: !1, line: 8, type: !23)
!29 = !DILocation(line: 8, column: 8, scope: !10)
!30 = !DILocation(line: 10, column: 21, scope: !10)
!31 = !DILocation(line: 10, column: 2, scope: !10)
!32 = !DILocation(line: 11, column: 21, scope: !10)
!33 = !DILocation(line: 11, column: 2, scope: !10)
!34 = !DILocation(line: 12, column: 21, scope: !10)
!35 = !DILocation(line: 12, column: 2, scope: !10)
!36 = !DILocation(line: 13, column: 25, scope: !10)
!37 = !DILocation(line: 13, column: 53, scope: !10)
!38 = !DILocation(line: 13, column: 59, scope: !10)
!39 = !DILocation(line: 13, column: 2, scope: !10)
!40 = !DILocation(line: 15, column: 6, scope: !41)
!41 = distinct !DILexicalBlock(scope: !10, file: !1, line: 15, column: 6)
!42 = !DILocation(line: 15, column: 10, scope: !41)
!43 = !DILocation(line: 15, column: 8, scope: !41)
!44 = !DILocation(line: 15, column: 12, scope: !41)
!45 = !DILocation(line: 15, column: 15, scope: !41)
!46 = !DILocation(line: 15, column: 19, scope: !41)
!47 = !DILocation(line: 15, column: 17, scope: !41)
!48 = !DILocation(line: 15, column: 21, scope: !41)
!49 = !DILocation(line: 15, column: 24, scope: !41)
!50 = !DILocation(line: 15, column: 28, scope: !41)
!51 = !DILocation(line: 15, column: 26, scope: !41)
!52 = !DILocation(line: 15, column: 30, scope: !41)
!53 = !DILocation(line: 15, column: 33, scope: !41)
!54 = !DILocation(line: 15, column: 37, scope: !41)
!55 = !DILocation(line: 15, column: 35, scope: !41)
!56 = !DILocation(line: 15, column: 6, scope: !10)
!57 = !DILocation(line: 17, column: 5, scope: !58)
!58 = distinct !DILexicalBlock(scope: !41, file: !1, line: 16, column: 2)
!59 = !DILocation(line: 18, column: 2, scope: !58)
!60 = !DILocation(line: 21, column: 7, scope: !61)
!61 = distinct !DILexicalBlock(scope: !62, file: !1, line: 21, column: 7)
!62 = distinct !DILexicalBlock(scope: !41, file: !1, line: 20, column: 2)
!63 = !DILocation(line: 21, column: 9, scope: !61)
!64 = !DILocation(line: 21, column: 7, scope: !62)
!65 = !DILocation(line: 23, column: 17, scope: !66)
!66 = distinct !DILexicalBlock(scope: !61, file: !1, line: 22, column: 3)
!67 = !DILocation(line: 23, column: 4, scope: !66)
!68 = !DILocation(line: 24, column: 3, scope: !66)
!69 = !DILocation(line: 27, column: 17, scope: !70)
!70 = distinct !DILexicalBlock(scope: !61, file: !1, line: 26, column: 3)
!71 = !DILocation(line: 27, column: 4, scope: !70)
!72 = !DILocation(line: 31, column: 6, scope: !73)
!73 = distinct !DILexicalBlock(scope: !10, file: !1, line: 31, column: 6)
!74 = !DILocation(line: 31, column: 10, scope: !73)
!75 = !DILocation(line: 31, column: 8, scope: !73)
!76 = !DILocation(line: 31, column: 6, scope: !10)
!77 = !DILocation(line: 33, column: 5, scope: !78)
!78 = distinct !DILexicalBlock(scope: !73, file: !1, line: 32, column: 2)
!79 = !DILocation(line: 34, column: 5, scope: !78)
!80 = !DILocation(line: 35, column: 2, scope: !78)
!81 = !DILocation(line: 38, column: 5, scope: !82)
!82 = distinct !DILexicalBlock(scope: !73, file: !1, line: 37, column: 2)
!83 = !DILocation(line: 39, column: 5, scope: !82)
!84 = !DILocation(line: 40, column: 5, scope: !82)
!85 = !DILocation(line: 43, column: 2, scope: !10)
!86 = distinct !DISubprogram(name: "memcpy", scope: !87, file: !87, line: 12, type: !88, scopeLine: 12, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !3, retainedNodes: !2)
!87 = !DIFile(filename: "klee/runtime/Freestanding/memcpy.c", directory: "/home/mlc6555")
!88 = !DISubroutineType(types: !89)
!89 = !{!90, !90, !91, !93}
!90 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!91 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!92 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!93 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !94, line: 46, baseType: !95)
!94 = !DIFile(filename: "/usr/lib/llvm-9/lib/clang/9.0.1/include/stddef.h", directory: "")
!95 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!96 = !DILocalVariable(name: "destaddr", arg: 1, scope: !86, file: !87, line: 12, type: !90)
!97 = !DILocation(line: 12, column: 20, scope: !86)
!98 = !DILocalVariable(name: "srcaddr", arg: 2, scope: !86, file: !87, line: 12, type: !91)
!99 = !DILocation(line: 12, column: 42, scope: !86)
!100 = !DILocalVariable(name: "len", arg: 3, scope: !86, file: !87, line: 12, type: !93)
!101 = !DILocation(line: 12, column: 58, scope: !86)
!102 = !DILocalVariable(name: "dest", scope: !86, file: !87, line: 13, type: !103)
!103 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !104, size: 64)
!104 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!105 = !DILocation(line: 13, column: 9, scope: !86)
!106 = !DILocation(line: 13, column: 16, scope: !86)
!107 = !DILocalVariable(name: "src", scope: !86, file: !87, line: 14, type: !108)
!108 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !109, size: 64)
!109 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !104)
!110 = !DILocation(line: 14, column: 15, scope: !86)
!111 = !DILocation(line: 14, column: 21, scope: !86)
!112 = !DILocation(line: 16, column: 3, scope: !86)
!113 = !DILocation(line: 16, column: 13, scope: !86)
!114 = !DILocation(line: 16, column: 16, scope: !86)
!115 = !DILocation(line: 17, column: 19, scope: !86)
!116 = !DILocation(line: 17, column: 15, scope: !86)
!117 = !DILocation(line: 17, column: 10, scope: !86)
!118 = !DILocation(line: 17, column: 13, scope: !86)
!119 = distinct !{!119, !112, !115}
!120 = !DILocation(line: 18, column: 10, scope: !86)
!121 = !DILocation(line: 18, column: 3, scope: !86)
