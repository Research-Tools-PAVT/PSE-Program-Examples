; ModuleID = 'example2.bc'
source_filename = "example2.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [6 x i8] c"a_sym\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"b_sym\00", align 1
@.str.2 = private unnamed_addr constant [6 x i8] c"c_sym\00", align 1

; Function Attrs: noinline norecurse uwtable
define dso_local i32 @main() #0 !dbg !7 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %3, metadata !13, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %4, metadata !15, metadata !DIExpression()), !dbg !16
  call void @llvm.dbg.declare(metadata i32* %5, metadata !17, metadata !DIExpression()), !dbg !18
  %6 = bitcast i32* %3 to i8*, !dbg !19
  call void @klee_make_symbolic(i8* %6, i64 4, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0)), !dbg !20
  %7 = bitcast i32* %4 to i8*, !dbg !21
  call void @klee_make_symbolic(i8* %7, i64 4, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0)), !dbg !22
  %8 = bitcast i32* %2 to i8*, !dbg !23
  call void @klee_make_symbolic(i8* %8, i64 4, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.2, i64 0, i64 0)), !dbg !24
  %9 = load i32, i32* %3, align 4, !dbg !25
  %10 = icmp sgt i32 %9, 0, !dbg !27
  %11 = load i32, i32* %2, align 4, !dbg !28
  %12 = icmp sgt i32 %11, 0, !dbg !29
  %or.cond = and i1 %10, %12, !dbg !30
  br i1 %or.cond, label %13, label %29, !dbg !30

13:                                               ; preds = %0
  %14 = load i32, i32* %2, align 4, !dbg !31
  %15 = load i32, i32* %5, align 4, !dbg !32
  %16 = icmp slt i32 %14, %15, !dbg !33
  br i1 %16, label %17, label %29, !dbg !34

17:                                               ; preds = %13
  %18 = load i32, i32* %5, align 4, !dbg !35
  %19 = load i32, i32* %3, align 4, !dbg !36
  %20 = icmp sgt i32 %18, %19, !dbg !37
  br i1 %20, label %21, label %29, !dbg !38

21:                                               ; preds = %17
  %22 = load i32, i32* %5, align 4, !dbg !39
  %23 = load i32, i32* %4, align 4, !dbg !40
  %24 = icmp sgt i32 %22, %23, !dbg !41
  br i1 %24, label %25, label %29, !dbg !42

25:                                               ; preds = %21
  %26 = load i32, i32* %3, align 4, !dbg !43
  %27 = load i32, i32* %4, align 4, !dbg !45
  %28 = mul nsw i32 %26, %27, !dbg !46
  store i32 %28, i32* %2, align 4, !dbg !47
  br label %33, !dbg !48

29:                                               ; preds = %21, %17, %13, %0
  %30 = load i32, i32* %3, align 4, !dbg !49
  %31 = load i32, i32* %4, align 4, !dbg !51
  %32 = add nsw i32 %30, %31, !dbg !52
  store i32 %32, i32* %5, align 4, !dbg !53
  br label %33

33:                                               ; preds = %29, %25
  %34 = load i32, i32* %2, align 4, !dbg !54
  %35 = load i32, i32* %5, align 4, !dbg !56
  %36 = icmp sgt i32 %34, %35, !dbg !57
  br i1 %36, label %37, label %38, !dbg !58

37:                                               ; preds = %33
  store i32 0, i32* %3, align 4, !dbg !59
  store i32 0, i32* %4, align 4, !dbg !61
  br label %38, !dbg !62

38:                                               ; preds = %37, %33
  ret i32 0, !dbg !63
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local void @klee_make_symbolic(i8*, i64, i8*) #2

attributes #0 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "example2.cpp", directory: "/home/mlc6555/Documents/Research/PSE-Program-Examples")
!2 = !{}
!3 = !{i32 7, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 10.0.0-4ubuntu1 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 8, type: !8, scopeLine: 9, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "c", scope: !7, file: !1, line: 10, type: !10)
!12 = !DILocation(line: 10, column: 7, scope: !7)
!13 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 10, type: !10)
!14 = !DILocation(line: 10, column: 10, scope: !7)
!15 = !DILocalVariable(name: "b", scope: !7, file: !1, line: 10, type: !10)
!16 = !DILocation(line: 10, column: 13, scope: !7)
!17 = !DILocalVariable(name: "d", scope: !7, file: !1, line: 10, type: !10)
!18 = !DILocation(line: 10, column: 16, scope: !7)
!19 = !DILocation(line: 12, column: 22, scope: !7)
!20 = !DILocation(line: 12, column: 3, scope: !7)
!21 = !DILocation(line: 13, column: 22, scope: !7)
!22 = !DILocation(line: 13, column: 3, scope: !7)
!23 = !DILocation(line: 14, column: 22, scope: !7)
!24 = !DILocation(line: 14, column: 3, scope: !7)
!25 = !DILocation(line: 16, column: 7, scope: !26)
!26 = distinct !DILexicalBlock(scope: !7, file: !1, line: 16, column: 7)
!27 = !DILocation(line: 16, column: 9, scope: !26)
!28 = !DILocation(line: 16, column: 16, scope: !26)
!29 = !DILocation(line: 16, column: 18, scope: !26)
!30 = !DILocation(line: 16, column: 13, scope: !26)
!31 = !DILocation(line: 16, column: 25, scope: !26)
!32 = !DILocation(line: 16, column: 29, scope: !26)
!33 = !DILocation(line: 16, column: 27, scope: !26)
!34 = !DILocation(line: 16, column: 31, scope: !26)
!35 = !DILocation(line: 16, column: 34, scope: !26)
!36 = !DILocation(line: 16, column: 38, scope: !26)
!37 = !DILocation(line: 16, column: 36, scope: !26)
!38 = !DILocation(line: 16, column: 40, scope: !26)
!39 = !DILocation(line: 16, column: 43, scope: !26)
!40 = !DILocation(line: 16, column: 47, scope: !26)
!41 = !DILocation(line: 16, column: 45, scope: !26)
!42 = !DILocation(line: 16, column: 7, scope: !7)
!43 = !DILocation(line: 18, column: 9, scope: !44)
!44 = distinct !DILexicalBlock(scope: !26, file: !1, line: 17, column: 3)
!45 = !DILocation(line: 18, column: 13, scope: !44)
!46 = !DILocation(line: 18, column: 11, scope: !44)
!47 = !DILocation(line: 18, column: 7, scope: !44)
!48 = !DILocation(line: 19, column: 3, scope: !44)
!49 = !DILocation(line: 22, column: 9, scope: !50)
!50 = distinct !DILexicalBlock(scope: !26, file: !1, line: 21, column: 3)
!51 = !DILocation(line: 22, column: 13, scope: !50)
!52 = !DILocation(line: 22, column: 11, scope: !50)
!53 = !DILocation(line: 22, column: 7, scope: !50)
!54 = !DILocation(line: 25, column: 7, scope: !55)
!55 = distinct !DILexicalBlock(scope: !7, file: !1, line: 25, column: 7)
!56 = !DILocation(line: 25, column: 11, scope: !55)
!57 = !DILocation(line: 25, column: 9, scope: !55)
!58 = !DILocation(line: 25, column: 7, scope: !7)
!59 = !DILocation(line: 27, column: 7, scope: !60)
!60 = distinct !DILexicalBlock(scope: !55, file: !1, line: 26, column: 3)
!61 = !DILocation(line: 28, column: 7, scope: !60)
!62 = !DILocation(line: 29, column: 3, scope: !60)
!63 = !DILocation(line: 31, column: 3, scope: !7)
