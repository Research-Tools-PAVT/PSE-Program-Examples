; ModuleID = 'example4.bc'
source_filename = "example4.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"a_sym\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"b_sym\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"c_sym\00", align 1
@.str.3 = private unnamed_addr constant [3 x i8] c"%d\00", align 1

; Function Attrs: noinline norecurse uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %3, metadata !13, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %4, metadata !15, metadata !DIExpression()), !dbg !16
  store i32 90, i32* %4, align 4, !dbg !16
  %5 = bitcast i32* %2 to i8*, !dbg !17
  call void @klee_make_symbolic(i8* %5, i64 4, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0)), !dbg !18
  %6 = bitcast i32* %3 to i8*, !dbg !19
  call void @klee_make_symbolic(i8* %6, i64 4, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0)), !dbg !20
  %7 = bitcast i32* %4 to i8*, !dbg !21
  call void @klee_make_symbolic(i8* %7, i64 4, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)), !dbg !22
  %8 = load i32, i32* %2, align 4, !dbg !23
  %9 = load i32, i32* %3, align 4, !dbg !25
  %10 = icmp sgt i32 %8, %9, !dbg !26
  %11 = load i32, i32* %4, align 4, !dbg !27
  br i1 %10, label %12, label %14, !dbg !28

12:                                               ; preds = %0
  %13 = mul nsw i32 %11, 9, !dbg !29
  store i32 %13, i32* %4, align 4, !dbg !29
  br label %22, !dbg !31

14:                                               ; preds = %0
  %15 = icmp sgt i32 %11, 0, !dbg !32
  br i1 %15, label %16, label %19, !dbg !35

16:                                               ; preds = %14
  %17 = load i32, i32* %3, align 4, !dbg !36
  %18 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i64 0, i64 0), i32 %17), !dbg !38
  br label %22, !dbg !39

19:                                               ; preds = %14
  %20 = load i32, i32* %2, align 4, !dbg !40
  %21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.3, i64 0, i64 0), i32 %20), !dbg !42
  br label %22

22:                                               ; preds = %16, %19, %12
  %23 = load i32, i32* %2, align 4, !dbg !43
  %24 = load i32, i32* %4, align 4, !dbg !45
  %25 = icmp sgt i32 %23, %24, !dbg !46
  br i1 %25, label %26, label %31, !dbg !47

26:                                               ; preds = %22
  %27 = load i32, i32* %3, align 4, !dbg !48
  %28 = mul nsw i32 %27, 8, !dbg !48
  store i32 %28, i32* %3, align 4, !dbg !48
  %29 = load i32, i32* %4, align 4, !dbg !50
  %30 = mul nsw i32 %29, 2, !dbg !50
  store i32 %30, i32* %4, align 4, !dbg !50
  br label %38, !dbg !51

31:                                               ; preds = %22
  %32 = load i32, i32* %2, align 4, !dbg !52
  %33 = mul nsw i32 %32, 2, !dbg !52
  store i32 %33, i32* %2, align 4, !dbg !52
  %34 = load i32, i32* %3, align 4, !dbg !54
  %35 = mul nsw i32 %34, 3, !dbg !54
  store i32 %35, i32* %3, align 4, !dbg !54
  %36 = load i32, i32* %4, align 4, !dbg !55
  %37 = mul nsw i32 %36, 4, !dbg !55
  store i32 %37, i32* %4, align 4, !dbg !55
  br label %38

38:                                               ; preds = %31, %26
  ret i32 0, !dbg !56
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local void @klee_make_symbolic(i8*, i64, i8*) #2

declare dso_local i32 @printf(i8*, ...) #2

attributes #0 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "example4.cpp", directory: "/home/mlc6555/Documents/Research/PSE-Program-Examples")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 4, type: !8, scopeLine: 5, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 6, type: !10)
!12 = !DILocation(line: 6, column: 6, scope: !7)
!13 = !DILocalVariable(name: "b", scope: !7, file: !1, line: 7, type: !10)
!14 = !DILocation(line: 7, column: 6, scope: !7)
!15 = !DILocalVariable(name: "c", scope: !7, file: !1, line: 8, type: !10)
!16 = !DILocation(line: 8, column: 6, scope: !7)
!17 = !DILocation(line: 9, column: 21, scope: !7)
!18 = !DILocation(line: 9, column: 2, scope: !7)
!19 = !DILocation(line: 10, column: 21, scope: !7)
!20 = !DILocation(line: 10, column: 2, scope: !7)
!21 = !DILocation(line: 11, column: 21, scope: !7)
!22 = !DILocation(line: 11, column: 2, scope: !7)
!23 = !DILocation(line: 13, column: 6, scope: !24)
!24 = distinct !DILexicalBlock(scope: !7, file: !1, line: 13, column: 6)
!25 = !DILocation(line: 13, column: 10, scope: !24)
!26 = !DILocation(line: 13, column: 8, scope: !24)
!27 = !DILocation(line: 0, scope: !24)
!28 = !DILocation(line: 13, column: 6, scope: !7)
!29 = !DILocation(line: 15, column: 5, scope: !30)
!30 = distinct !DILexicalBlock(scope: !24, file: !1, line: 14, column: 2)
!31 = !DILocation(line: 16, column: 2, scope: !30)
!32 = !DILocation(line: 19, column: 9, scope: !33)
!33 = distinct !DILexicalBlock(scope: !34, file: !1, line: 19, column: 7)
!34 = distinct !DILexicalBlock(scope: !24, file: !1, line: 18, column: 2)
!35 = !DILocation(line: 19, column: 7, scope: !34)
!36 = !DILocation(line: 21, column: 17, scope: !37)
!37 = distinct !DILexicalBlock(scope: !33, file: !1, line: 20, column: 3)
!38 = !DILocation(line: 21, column: 4, scope: !37)
!39 = !DILocation(line: 22, column: 3, scope: !37)
!40 = !DILocation(line: 25, column: 17, scope: !41)
!41 = distinct !DILexicalBlock(scope: !33, file: !1, line: 24, column: 3)
!42 = !DILocation(line: 25, column: 4, scope: !41)
!43 = !DILocation(line: 29, column: 6, scope: !44)
!44 = distinct !DILexicalBlock(scope: !7, file: !1, line: 29, column: 6)
!45 = !DILocation(line: 29, column: 10, scope: !44)
!46 = !DILocation(line: 29, column: 8, scope: !44)
!47 = !DILocation(line: 29, column: 6, scope: !7)
!48 = !DILocation(line: 31, column: 5, scope: !49)
!49 = distinct !DILexicalBlock(scope: !44, file: !1, line: 30, column: 2)
!50 = !DILocation(line: 32, column: 5, scope: !49)
!51 = !DILocation(line: 33, column: 2, scope: !49)
!52 = !DILocation(line: 36, column: 5, scope: !53)
!53 = distinct !DILexicalBlock(scope: !44, file: !1, line: 35, column: 2)
!54 = !DILocation(line: 37, column: 5, scope: !53)
!55 = !DILocation(line: 38, column: 5, scope: !53)
!56 = !DILocation(line: 41, column: 2, scope: !7)
