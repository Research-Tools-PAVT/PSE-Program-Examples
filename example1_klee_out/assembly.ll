; ModuleID = 'example1.bc'
source_filename = "example1.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

$_Z17make_pse_symbolicIiEvPvmPKcOT_S4_ = comdat any

$_ZSt3minIiERKT_S2_S2_ = comdat any

$_ZSt3maxIiERKT_S2_S2_ = comdat any

@.str = private unnamed_addr constant [6 x i8] c"a_sym\00", align 1
@.str.1 = private unnamed_addr constant [6 x i8] c"b_sym\00", align 1
@.str.2 = private unnamed_addr constant [11 x i8] c"c_prob_sym\00", align 1
@.str.3 = private unnamed_addr constant [11 x i8] c"d_prob_sym\00", align 1

; Function Attrs: noinline nounwind uwtable
define dso_local i32 @_Z6getmaxii(i32 %0, i32 %1) #0 !dbg !284 {
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  store i32 %0, i32* %3, align 4
  call void @llvm.dbg.declare(metadata i32* %3, metadata !287, metadata !DIExpression()), !dbg !288
  store i32 %1, i32* %4, align 4
  call void @llvm.dbg.declare(metadata i32* %4, metadata !289, metadata !DIExpression()), !dbg !290
  %5 = load i32, i32* %3, align 4, !dbg !291
  %6 = load i32, i32* %4, align 4, !dbg !292
  %7 = icmp sgt i32 %5, %6, !dbg !293
  %8 = load i32, i32* %3, align 4, !dbg !291
  %9 = load i32, i32* %4, align 4, !dbg !291
  %10 = select i1 %7, i32 %8, i32 %9, !dbg !291
  ret i32 %10, !dbg !294
}

; Function Attrs: nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline norecurse uwtable
define dso_local i32 @main() #2 !dbg !295 {
  %1 = alloca i32, align 4
  %2 = alloca i32, align 4
  %3 = alloca i32, align 4
  %4 = alloca i32, align 4
  %5 = alloca i32, align 4
  %6 = alloca i32, align 4
  %7 = alloca i32, align 4
  %8 = alloca i32, align 4
  %9 = alloca i32, align 4
  %10 = alloca i32, align 4
  %11 = alloca i32, align 4
  store i32 0, i32* %1, align 4
  call void @llvm.dbg.declare(metadata i32* %2, metadata !296, metadata !DIExpression()), !dbg !297
  call void @llvm.dbg.declare(metadata i32* %3, metadata !298, metadata !DIExpression()), !dbg !299
  call void @llvm.dbg.declare(metadata i32* %4, metadata !300, metadata !DIExpression()), !dbg !301
  call void @llvm.dbg.declare(metadata i32* %5, metadata !302, metadata !DIExpression()), !dbg !303
  %12 = bitcast i32* %2 to i8*, !dbg !304
  call void @klee_make_symbolic(i8* %12, i64 4, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i64 0, i64 0)), !dbg !305
  %13 = bitcast i32* %3 to i8*, !dbg !306
  store i32 0, i32* %6, align 4, !dbg !307
  store i32 20, i32* %7, align 4, !dbg !308
  call void @_Z17make_pse_symbolicIiEvPvmPKcOT_S4_(i8* %13, i64 4, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1, i64 0, i64 0), i32* dereferenceable(4) %6, i32* dereferenceable(4) %7), !dbg !309
  %14 = bitcast i32* %4 to i8*, !dbg !310
  store i32 0, i32* %8, align 4, !dbg !311
  store i32 800, i32* %9, align 4, !dbg !312
  call void @_Z17make_pse_symbolicIiEvPvmPKcOT_S4_(i8* %14, i64 4, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.2, i64 0, i64 0), i32* dereferenceable(4) %8, i32* dereferenceable(4) %9), !dbg !313
  %15 = bitcast i32* %5 to i8*, !dbg !314
  store i32 0, i32* %10, align 4, !dbg !315
  store i32 650, i32* %11, align 4, !dbg !316
  call void @_Z17make_pse_symbolicIiEvPvmPKcOT_S4_(i8* %15, i64 4, i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str.3, i64 0, i64 0), i32* dereferenceable(4) %10, i32* dereferenceable(4) %11), !dbg !317
  %16 = load i32, i32* %2, align 4, !dbg !318
  %17 = load i32, i32* %3, align 4, !dbg !320
  %18 = icmp sgt i32 %16, %17, !dbg !321
  %19 = load i32, i32* %4, align 4, !dbg !322
  br i1 %18, label %20, label %24, !dbg !323

20:                                               ; preds = %0
  %21 = mul nsw i32 %19, 2, !dbg !324
  store i32 %21, i32* %2, align 4, !dbg !326
  %22 = load i32, i32* %5, align 4, !dbg !327
  %23 = mul nsw i32 %22, 2, !dbg !328
  store i32 %23, i32* %3, align 4, !dbg !329
  br label %39, !dbg !330

24:                                               ; preds = %0
  %25 = load i32, i32* %5, align 4, !dbg !331
  %26 = icmp sgt i32 %19, %25, !dbg !333
  br i1 %26, label %27, label %32, !dbg !334

27:                                               ; preds = %24
  %28 = load i32, i32* %2, align 4, !dbg !335
  %29 = mul nsw i32 %28, 3, !dbg !337
  store i32 %29, i32* %4, align 4, !dbg !338
  %30 = load i32, i32* %3, align 4, !dbg !339
  %31 = mul nsw i32 %30, 3, !dbg !340
  store i32 %31, i32* %5, align 4, !dbg !341
  br label %39, !dbg !342

32:                                               ; preds = %24
  %33 = load i32, i32* %4, align 4, !dbg !343
  %34 = load i32, i32* %5, align 4, !dbg !345
  %35 = call i32 @_Z6getmaxii(i32 %33, i32 %34), !dbg !346
  store i32 %35, i32* %2, align 4, !dbg !347
  %36 = load i32, i32* %4, align 4, !dbg !348
  %37 = load i32, i32* %3, align 4, !dbg !349
  %38 = call i32 @_Z6getmaxii(i32 %36, i32 %37), !dbg !350
  store i32 %38, i32* %3, align 4, !dbg !351
  br label %39

39:                                               ; preds = %27, %32, %20
  %40 = load i32, i32* %2, align 4, !dbg !352
  %41 = icmp sge i32 %40, 0, !dbg !354
  %42 = load i32, i32* %3, align 4, !dbg !355
  %43 = icmp sge i32 %42, 0, !dbg !356
  %or.cond = and i1 %41, %43, !dbg !357
  br i1 %or.cond, label %44, label %50, !dbg !357

44:                                               ; preds = %39
  %45 = load i32, i32* %4, align 4, !dbg !358
  %46 = add nsw i32 %45, 1, !dbg !360
  store i32 %46, i32* %4, align 4, !dbg !361
  %47 = load i32, i32* %2, align 4, !dbg !362
  %48 = load i32, i32* %3, align 4, !dbg !363
  %49 = call i32 @_Z6getmaxii(i32 %47, i32 %48), !dbg !364
  store i32 %49, i32* %5, align 4, !dbg !365
  br label %50, !dbg !366

50:                                               ; preds = %44, %39
  %51 = load i32, i32* %4, align 4, !dbg !367
  %52 = icmp sgt i32 %51, 0, !dbg !369
  br i1 %52, label %53, label %54, !dbg !370

53:                                               ; preds = %50
  store i32 0, i32* %3, align 4, !dbg !371
  br label %54, !dbg !373

54:                                               ; preds = %53, %50
  ret i32 0, !dbg !374
}

declare dso_local void @klee_make_symbolic(i8*, i64, i8*) #3

; Function Attrs: noinline uwtable
define linkonce_odr dso_local void @_Z17make_pse_symbolicIiEvPvmPKcOT_S4_(i8* %0, i64 %1, i8* %2, i32* dereferenceable(4) %3, i32* dereferenceable(4) %4) #4 comdat !dbg !375 {
  %6 = alloca i8*, align 8
  %7 = alloca i64, align 8
  %8 = alloca i8*, align 8
  %9 = alloca i32*, align 8
  %10 = alloca i32*, align 8
  store i8* %0, i8** %6, align 8
  call void @llvm.dbg.declare(metadata i8** %6, metadata !382, metadata !DIExpression()), !dbg !383
  store i64 %1, i64* %7, align 8
  call void @llvm.dbg.declare(metadata i64* %7, metadata !384, metadata !DIExpression()), !dbg !385
  store i8* %2, i8** %8, align 8
  call void @llvm.dbg.declare(metadata i8** %8, metadata !386, metadata !DIExpression()), !dbg !387
  store i32* %3, i32** %9, align 8
  call void @llvm.dbg.declare(metadata i32** %9, metadata !388, metadata !DIExpression()), !dbg !389
  store i32* %4, i32** %10, align 8
  call void @llvm.dbg.declare(metadata i32** %10, metadata !390, metadata !DIExpression()), !dbg !391
  %11 = load i8*, i8** %6, align 8, !dbg !392
  %12 = load i64, i64* %7, align 8, !dbg !393
  %13 = load i8*, i8** %8, align 8, !dbg !394
  call void @klee_make_symbolic(i8* %11, i64 %12, i8* %13), !dbg !395
  %14 = load i8*, i8** %6, align 8, !dbg !396
  %15 = bitcast i8* %14 to i32*, !dbg !397
  %16 = load i32, i32* %15, align 4, !dbg !398
  %17 = load i32*, i32** %9, align 8, !dbg !399
  %18 = load i32*, i32** %10, align 8, !dbg !400
  %19 = call dereferenceable(4) i32* @_ZSt3minIiERKT_S2_S2_(i32* dereferenceable(4) %17, i32* dereferenceable(4) %18), !dbg !401
  %20 = load i32, i32* %19, align 4, !dbg !401
  %21 = icmp sge i32 %16, %20, !dbg !402
  %22 = zext i1 %21 to i64, !dbg !398
  call void @klee_assume(i64 %22), !dbg !403
  %23 = load i8*, i8** %6, align 8, !dbg !404
  %24 = bitcast i8* %23 to i32*, !dbg !405
  %25 = load i32, i32* %24, align 4, !dbg !406
  %26 = load i32*, i32** %9, align 8, !dbg !407
  %27 = load i32*, i32** %10, align 8, !dbg !408
  %28 = call dereferenceable(4) i32* @_ZSt3maxIiERKT_S2_S2_(i32* dereferenceable(4) %26, i32* dereferenceable(4) %27), !dbg !409
  %29 = load i32, i32* %28, align 4, !dbg !409
  %30 = icmp sle i32 %25, %29, !dbg !410
  %31 = zext i1 %30 to i64, !dbg !406
  call void @klee_assume(i64 %31), !dbg !411
  ret void, !dbg !412
}

declare dso_local void @klee_assume(i64) #3

; Function Attrs: noinline nounwind uwtable
define linkonce_odr dso_local dereferenceable(4) i32* @_ZSt3minIiERKT_S2_S2_(i32* dereferenceable(4) %0, i32* dereferenceable(4) %1) #0 comdat !dbg !413 {
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  %5 = alloca i32*, align 8
  store i32* %0, i32** %4, align 8
  call void @llvm.dbg.declare(metadata i32** %4, metadata !421, metadata !DIExpression()), !dbg !423
  store i32* %1, i32** %5, align 8
  call void @llvm.dbg.declare(metadata i32** %5, metadata !424, metadata !DIExpression()), !dbg !425
  %6 = load i32*, i32** %5, align 8, !dbg !426
  %7 = load i32, i32* %6, align 4, !dbg !426
  %8 = load i32*, i32** %4, align 8, !dbg !428
  %9 = load i32, i32* %8, align 4, !dbg !428
  %10 = icmp slt i32 %7, %9, !dbg !429
  br i1 %10, label %11, label %13, !dbg !430

11:                                               ; preds = %2
  %12 = load i32*, i32** %5, align 8, !dbg !431
  store i32* %12, i32** %3, align 8, !dbg !432
  br label %15, !dbg !432

13:                                               ; preds = %2
  %14 = load i32*, i32** %4, align 8, !dbg !433
  store i32* %14, i32** %3, align 8, !dbg !434
  br label %15, !dbg !434

15:                                               ; preds = %13, %11
  %16 = load i32*, i32** %3, align 8, !dbg !435
  ret i32* %16, !dbg !435
}

; Function Attrs: noinline nounwind uwtable
define linkonce_odr dso_local dereferenceable(4) i32* @_ZSt3maxIiERKT_S2_S2_(i32* dereferenceable(4) %0, i32* dereferenceable(4) %1) #0 comdat !dbg !436 {
  %3 = alloca i32*, align 8
  %4 = alloca i32*, align 8
  %5 = alloca i32*, align 8
  store i32* %0, i32** %4, align 8
  call void @llvm.dbg.declare(metadata i32** %4, metadata !437, metadata !DIExpression()), !dbg !438
  store i32* %1, i32** %5, align 8
  call void @llvm.dbg.declare(metadata i32** %5, metadata !439, metadata !DIExpression()), !dbg !440
  %6 = load i32*, i32** %4, align 8, !dbg !441
  %7 = load i32, i32* %6, align 4, !dbg !441
  %8 = load i32*, i32** %5, align 8, !dbg !443
  %9 = load i32, i32* %8, align 4, !dbg !443
  %10 = icmp slt i32 %7, %9, !dbg !444
  br i1 %10, label %11, label %13, !dbg !445

11:                                               ; preds = %2
  %12 = load i32*, i32** %5, align 8, !dbg !446
  store i32* %12, i32** %3, align 8, !dbg !447
  br label %15, !dbg !447

13:                                               ; preds = %2
  %14 = load i32*, i32** %4, align 8, !dbg !448
  store i32* %14, i32** %3, align 8, !dbg !449
  br label %15, !dbg !449

15:                                               ; preds = %13, %11
  %16 = load i32*, i32** %3, align 8, !dbg !450
  ret i32* %16, !dbg !450
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable willreturn }
attributes #2 = { noinline norecurse uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noinline uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="all" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!280, !281, !282}
!llvm.ident = !{!283}

!0 = distinct !DICompileUnit(language: DW_LANG_C_plus_plus_14, file: !1, producer: "clang version 10.0.0-4ubuntu1 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3, imports: !6, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "example1.cpp", directory: "/home/ha-useast-service/Documents/Research/PSE-Program-Examples")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !5, size: 64)
!5 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!6 = !{!7, !12, !18, !22, !29, !33, !41, !46, !48, !56, !60, !64, !74, !76, !80, !84, !88, !93, !97, !101, !105, !109, !117, !121, !125, !127, !131, !135, !140, !146, !150, !154, !156, !164, !168, !176, !178, !182, !186, !190, !194, !199, !204, !209, !210, !211, !212, !214, !215, !216, !217, !218, !219, !220, !276}
!7 = !DIImportedEntity(tag: DW_TAG_imported_module, scope: !8, entity: !9, file: !11, line: 58)
!8 = !DINamespace(name: "__gnu_debug", scope: null)
!9 = !DINamespace(name: "__debug", scope: !10)
!10 = !DINamespace(name: "std", scope: null)
!11 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/10/../../../../include/c++/10/debug/debug.h", directory: "")
!12 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !13, file: !17, line: 52)
!13 = !DISubprogram(name: "abs", scope: !14, file: !14, line: 840, type: !15, flags: DIFlagPrototyped, spFlags: 0)
!14 = !DIFile(filename: "/usr/include/stdlib.h", directory: "")
!15 = !DISubroutineType(types: !16)
!16 = !{!5, !5}
!17 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/10/../../../../include/c++/10/bits/std_abs.h", directory: "")
!18 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !19, file: !21, line: 127)
!19 = !DIDerivedType(tag: DW_TAG_typedef, name: "div_t", file: !14, line: 62, baseType: !20)
!20 = !DICompositeType(tag: DW_TAG_structure_type, file: !14, line: 58, flags: DIFlagFwdDecl, identifier: "_ZTS5div_t")
!21 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/10/../../../../include/c++/10/cstdlib", directory: "")
!22 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !23, file: !21, line: 128)
!23 = !DIDerivedType(tag: DW_TAG_typedef, name: "ldiv_t", file: !14, line: 70, baseType: !24)
!24 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !14, line: 66, size: 128, flags: DIFlagTypePassByValue, elements: !25, identifier: "_ZTS6ldiv_t")
!25 = !{!26, !28}
!26 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !24, file: !14, line: 68, baseType: !27, size: 64)
!27 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!28 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !24, file: !14, line: 69, baseType: !27, size: 64, offset: 64)
!29 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !30, file: !21, line: 130)
!30 = !DISubprogram(name: "abort", scope: !14, file: !14, line: 591, type: !31, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!31 = !DISubroutineType(types: !32)
!32 = !{null}
!33 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !34, file: !21, line: 132)
!34 = !DISubprogram(name: "aligned_alloc", scope: !14, file: !14, line: 586, type: !35, flags: DIFlagPrototyped, spFlags: 0)
!35 = !DISubroutineType(types: !36)
!36 = !{!37, !38, !38}
!37 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!38 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !39, line: 46, baseType: !40)
!39 = !DIFile(filename: "/usr/lib/llvm-10/lib/clang/10.0.0/include/stddef.h", directory: "")
!40 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!41 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !42, file: !21, line: 134)
!42 = !DISubprogram(name: "atexit", scope: !14, file: !14, line: 595, type: !43, flags: DIFlagPrototyped, spFlags: 0)
!43 = !DISubroutineType(types: !44)
!44 = !{!5, !45}
!45 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !31, size: 64)
!46 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !47, file: !21, line: 137)
!47 = !DISubprogram(name: "at_quick_exit", scope: !14, file: !14, line: 600, type: !43, flags: DIFlagPrototyped, spFlags: 0)
!48 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !49, file: !21, line: 140)
!49 = !DISubprogram(name: "atof", scope: !14, file: !14, line: 101, type: !50, flags: DIFlagPrototyped, spFlags: 0)
!50 = !DISubroutineType(types: !51)
!51 = !{!52, !53}
!52 = !DIBasicType(name: "double", size: 64, encoding: DW_ATE_float)
!53 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !54, size: 64)
!54 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !55)
!55 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!56 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !57, file: !21, line: 141)
!57 = !DISubprogram(name: "atoi", scope: !14, file: !14, line: 104, type: !58, flags: DIFlagPrototyped, spFlags: 0)
!58 = !DISubroutineType(types: !59)
!59 = !{!5, !53}
!60 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !61, file: !21, line: 142)
!61 = !DISubprogram(name: "atol", scope: !14, file: !14, line: 107, type: !62, flags: DIFlagPrototyped, spFlags: 0)
!62 = !DISubroutineType(types: !63)
!63 = !{!27, !53}
!64 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !65, file: !21, line: 143)
!65 = !DISubprogram(name: "bsearch", scope: !14, file: !14, line: 820, type: !66, flags: DIFlagPrototyped, spFlags: 0)
!66 = !DISubroutineType(types: !67)
!67 = !{!37, !68, !68, !38, !38, !70}
!68 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !69, size: 64)
!69 = !DIDerivedType(tag: DW_TAG_const_type, baseType: null)
!70 = !DIDerivedType(tag: DW_TAG_typedef, name: "__compar_fn_t", file: !14, line: 808, baseType: !71)
!71 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !72, size: 64)
!72 = !DISubroutineType(types: !73)
!73 = !{!5, !68, !68}
!74 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !75, file: !21, line: 144)
!75 = !DISubprogram(name: "calloc", scope: !14, file: !14, line: 542, type: !35, flags: DIFlagPrototyped, spFlags: 0)
!76 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !77, file: !21, line: 145)
!77 = !DISubprogram(name: "div", scope: !14, file: !14, line: 852, type: !78, flags: DIFlagPrototyped, spFlags: 0)
!78 = !DISubroutineType(types: !79)
!79 = !{!19, !5, !5}
!80 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !81, file: !21, line: 146)
!81 = !DISubprogram(name: "exit", scope: !14, file: !14, line: 617, type: !82, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!82 = !DISubroutineType(types: !83)
!83 = !{null, !5}
!84 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !85, file: !21, line: 147)
!85 = !DISubprogram(name: "free", scope: !14, file: !14, line: 565, type: !86, flags: DIFlagPrototyped, spFlags: 0)
!86 = !DISubroutineType(types: !87)
!87 = !{null, !37}
!88 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !89, file: !21, line: 148)
!89 = !DISubprogram(name: "getenv", scope: !14, file: !14, line: 634, type: !90, flags: DIFlagPrototyped, spFlags: 0)
!90 = !DISubroutineType(types: !91)
!91 = !{!92, !53}
!92 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!93 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !94, file: !21, line: 149)
!94 = !DISubprogram(name: "labs", scope: !14, file: !14, line: 841, type: !95, flags: DIFlagPrototyped, spFlags: 0)
!95 = !DISubroutineType(types: !96)
!96 = !{!27, !27}
!97 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !98, file: !21, line: 150)
!98 = !DISubprogram(name: "ldiv", scope: !14, file: !14, line: 854, type: !99, flags: DIFlagPrototyped, spFlags: 0)
!99 = !DISubroutineType(types: !100)
!100 = !{!23, !27, !27}
!101 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !102, file: !21, line: 151)
!102 = !DISubprogram(name: "malloc", scope: !14, file: !14, line: 539, type: !103, flags: DIFlagPrototyped, spFlags: 0)
!103 = !DISubroutineType(types: !104)
!104 = !{!37, !38}
!105 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !106, file: !21, line: 153)
!106 = !DISubprogram(name: "mblen", scope: !14, file: !14, line: 922, type: !107, flags: DIFlagPrototyped, spFlags: 0)
!107 = !DISubroutineType(types: !108)
!108 = !{!5, !53, !38}
!109 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !110, file: !21, line: 154)
!110 = !DISubprogram(name: "mbstowcs", scope: !14, file: !14, line: 933, type: !111, flags: DIFlagPrototyped, spFlags: 0)
!111 = !DISubroutineType(types: !112)
!112 = !{!38, !113, !116, !38}
!113 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !114)
!114 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !115, size: 64)
!115 = !DIBasicType(name: "wchar_t", size: 32, encoding: DW_ATE_signed)
!116 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !53)
!117 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !118, file: !21, line: 155)
!118 = !DISubprogram(name: "mbtowc", scope: !14, file: !14, line: 925, type: !119, flags: DIFlagPrototyped, spFlags: 0)
!119 = !DISubroutineType(types: !120)
!120 = !{!5, !113, !116, !38}
!121 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !122, file: !21, line: 157)
!122 = !DISubprogram(name: "qsort", scope: !14, file: !14, line: 830, type: !123, flags: DIFlagPrototyped, spFlags: 0)
!123 = !DISubroutineType(types: !124)
!124 = !{null, !37, !38, !38, !70}
!125 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !126, file: !21, line: 160)
!126 = !DISubprogram(name: "quick_exit", scope: !14, file: !14, line: 623, type: !82, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!127 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !128, file: !21, line: 163)
!128 = !DISubprogram(name: "rand", scope: !14, file: !14, line: 453, type: !129, flags: DIFlagPrototyped, spFlags: 0)
!129 = !DISubroutineType(types: !130)
!130 = !{!5}
!131 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !132, file: !21, line: 164)
!132 = !DISubprogram(name: "realloc", scope: !14, file: !14, line: 550, type: !133, flags: DIFlagPrototyped, spFlags: 0)
!133 = !DISubroutineType(types: !134)
!134 = !{!37, !37, !38}
!135 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !136, file: !21, line: 165)
!136 = !DISubprogram(name: "srand", scope: !14, file: !14, line: 455, type: !137, flags: DIFlagPrototyped, spFlags: 0)
!137 = !DISubroutineType(types: !138)
!138 = !{null, !139}
!139 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!140 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !141, file: !21, line: 166)
!141 = !DISubprogram(name: "strtod", scope: !14, file: !14, line: 117, type: !142, flags: DIFlagPrototyped, spFlags: 0)
!142 = !DISubroutineType(types: !143)
!143 = !{!52, !116, !144}
!144 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !145)
!145 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !92, size: 64)
!146 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !147, file: !21, line: 167)
!147 = !DISubprogram(name: "strtol", scope: !14, file: !14, line: 176, type: !148, flags: DIFlagPrototyped, spFlags: 0)
!148 = !DISubroutineType(types: !149)
!149 = !{!27, !116, !144, !5}
!150 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !151, file: !21, line: 168)
!151 = !DISubprogram(name: "strtoul", scope: !14, file: !14, line: 180, type: !152, flags: DIFlagPrototyped, spFlags: 0)
!152 = !DISubroutineType(types: !153)
!153 = !{!40, !116, !144, !5}
!154 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !155, file: !21, line: 169)
!155 = !DISubprogram(name: "system", scope: !14, file: !14, line: 784, type: !58, flags: DIFlagPrototyped, spFlags: 0)
!156 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !157, file: !21, line: 171)
!157 = !DISubprogram(name: "wcstombs", scope: !14, file: !14, line: 936, type: !158, flags: DIFlagPrototyped, spFlags: 0)
!158 = !DISubroutineType(types: !159)
!159 = !{!38, !160, !161, !38}
!160 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !92)
!161 = !DIDerivedType(tag: DW_TAG_restrict_type, baseType: !162)
!162 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !163, size: 64)
!163 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !115)
!164 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !165, file: !21, line: 172)
!165 = !DISubprogram(name: "wctomb", scope: !14, file: !14, line: 929, type: !166, flags: DIFlagPrototyped, spFlags: 0)
!166 = !DISubroutineType(types: !167)
!167 = !{!5, !92, !115}
!168 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !170, file: !21, line: 200)
!169 = !DINamespace(name: "__gnu_cxx", scope: null)
!170 = !DIDerivedType(tag: DW_TAG_typedef, name: "lldiv_t", file: !14, line: 80, baseType: !171)
!171 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !14, line: 76, size: 128, flags: DIFlagTypePassByValue, elements: !172, identifier: "_ZTS7lldiv_t")
!172 = !{!173, !175}
!173 = !DIDerivedType(tag: DW_TAG_member, name: "quot", scope: !171, file: !14, line: 78, baseType: !174, size: 64)
!174 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!175 = !DIDerivedType(tag: DW_TAG_member, name: "rem", scope: !171, file: !14, line: 79, baseType: !174, size: 64, offset: 64)
!176 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !177, file: !21, line: 206)
!177 = !DISubprogram(name: "_Exit", scope: !14, file: !14, line: 629, type: !82, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!178 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !179, file: !21, line: 210)
!179 = !DISubprogram(name: "llabs", scope: !14, file: !14, line: 844, type: !180, flags: DIFlagPrototyped, spFlags: 0)
!180 = !DISubroutineType(types: !181)
!181 = !{!174, !174}
!182 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !183, file: !21, line: 216)
!183 = !DISubprogram(name: "lldiv", scope: !14, file: !14, line: 858, type: !184, flags: DIFlagPrototyped, spFlags: 0)
!184 = !DISubroutineType(types: !185)
!185 = !{!170, !174, !174}
!186 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !187, file: !21, line: 227)
!187 = !DISubprogram(name: "atoll", scope: !14, file: !14, line: 112, type: !188, flags: DIFlagPrototyped, spFlags: 0)
!188 = !DISubroutineType(types: !189)
!189 = !{!174, !53}
!190 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !191, file: !21, line: 228)
!191 = !DISubprogram(name: "strtoll", scope: !14, file: !14, line: 200, type: !192, flags: DIFlagPrototyped, spFlags: 0)
!192 = !DISubroutineType(types: !193)
!193 = !{!174, !116, !144, !5}
!194 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !195, file: !21, line: 229)
!195 = !DISubprogram(name: "strtoull", scope: !14, file: !14, line: 205, type: !196, flags: DIFlagPrototyped, spFlags: 0)
!196 = !DISubroutineType(types: !197)
!197 = !{!198, !116, !144, !5}
!198 = !DIBasicType(name: "long long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!199 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !200, file: !21, line: 231)
!200 = !DISubprogram(name: "strtof", scope: !14, file: !14, line: 123, type: !201, flags: DIFlagPrototyped, spFlags: 0)
!201 = !DISubroutineType(types: !202)
!202 = !{!203, !116, !144}
!203 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!204 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !169, entity: !205, file: !21, line: 232)
!205 = !DISubprogram(name: "strtold", scope: !14, file: !14, line: 126, type: !206, flags: DIFlagPrototyped, spFlags: 0)
!206 = !DISubroutineType(types: !207)
!207 = !{!208, !116, !144}
!208 = !DIBasicType(name: "long double", size: 128, encoding: DW_ATE_float)
!209 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !170, file: !21, line: 240)
!210 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !177, file: !21, line: 242)
!211 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !179, file: !21, line: 244)
!212 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !213, file: !21, line: 245)
!213 = !DISubprogram(name: "div", linkageName: "_ZN9__gnu_cxx3divExx", scope: !169, file: !21, line: 213, type: !184, flags: DIFlagPrototyped, spFlags: 0)
!214 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !183, file: !21, line: 246)
!215 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !187, file: !21, line: 248)
!216 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !200, file: !21, line: 249)
!217 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !191, file: !21, line: 250)
!218 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !195, file: !21, line: 251)
!219 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !205, file: !21, line: 252)
!220 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !10, entity: !221, file: !222, line: 58)
!221 = distinct !DICompositeType(tag: DW_TAG_class_type, name: "exception_ptr", scope: !223, file: !222, line: 80, size: 64, flags: DIFlagTypePassByReference | DIFlagNonTrivial, elements: !224, identifier: "_ZTSNSt15__exception_ptr13exception_ptrE")
!222 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/10/../../../../include/c++/10/bits/exception_ptr.h", directory: "")
!223 = !DINamespace(name: "__exception_ptr", scope: !10)
!224 = !{!225, !226, !230, !233, !234, !239, !240, !244, !250, !254, !258, !261, !262, !265, !269}
!225 = !DIDerivedType(tag: DW_TAG_member, name: "_M_exception_object", scope: !221, file: !222, line: 82, baseType: !37, size: 64)
!226 = !DISubprogram(name: "exception_ptr", scope: !221, file: !222, line: 84, type: !227, scopeLine: 84, flags: DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!227 = !DISubroutineType(types: !228)
!228 = !{null, !229, !37}
!229 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !221, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!230 = !DISubprogram(name: "_M_addref", linkageName: "_ZNSt15__exception_ptr13exception_ptr9_M_addrefEv", scope: !221, file: !222, line: 86, type: !231, scopeLine: 86, flags: DIFlagPrototyped, spFlags: 0)
!231 = !DISubroutineType(types: !232)
!232 = !{null, !229}
!233 = !DISubprogram(name: "_M_release", linkageName: "_ZNSt15__exception_ptr13exception_ptr10_M_releaseEv", scope: !221, file: !222, line: 87, type: !231, scopeLine: 87, flags: DIFlagPrototyped, spFlags: 0)
!234 = !DISubprogram(name: "_M_get", linkageName: "_ZNKSt15__exception_ptr13exception_ptr6_M_getEv", scope: !221, file: !222, line: 89, type: !235, scopeLine: 89, flags: DIFlagPrototyped, spFlags: 0)
!235 = !DISubroutineType(types: !236)
!236 = !{!37, !237}
!237 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !238, size: 64, flags: DIFlagArtificial | DIFlagObjectPointer)
!238 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !221)
!239 = !DISubprogram(name: "exception_ptr", scope: !221, file: !222, line: 97, type: !231, scopeLine: 97, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!240 = !DISubprogram(name: "exception_ptr", scope: !221, file: !222, line: 99, type: !241, scopeLine: 99, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!241 = !DISubroutineType(types: !242)
!242 = !{null, !229, !243}
!243 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !238, size: 64)
!244 = !DISubprogram(name: "exception_ptr", scope: !221, file: !222, line: 102, type: !245, scopeLine: 102, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!245 = !DISubroutineType(types: !246)
!246 = !{null, !229, !247}
!247 = !DIDerivedType(tag: DW_TAG_typedef, name: "nullptr_t", scope: !10, file: !248, line: 264, baseType: !249)
!248 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/10/../../../../include/x86_64-linux-gnu/c++/10/bits/c++config.h", directory: "")
!249 = !DIBasicType(tag: DW_TAG_unspecified_type, name: "decltype(nullptr)")
!250 = !DISubprogram(name: "exception_ptr", scope: !221, file: !222, line: 106, type: !251, scopeLine: 106, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!251 = !DISubroutineType(types: !252)
!252 = !{null, !229, !253}
!253 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !221, size: 64)
!254 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__exception_ptr13exception_ptraSERKS0_", scope: !221, file: !222, line: 119, type: !255, scopeLine: 119, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!255 = !DISubroutineType(types: !256)
!256 = !{!257, !229, !243}
!257 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !221, size: 64)
!258 = !DISubprogram(name: "operator=", linkageName: "_ZNSt15__exception_ptr13exception_ptraSEOS0_", scope: !221, file: !222, line: 123, type: !259, scopeLine: 123, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!259 = !DISubroutineType(types: !260)
!260 = !{!257, !229, !253}
!261 = !DISubprogram(name: "~exception_ptr", scope: !221, file: !222, line: 130, type: !231, scopeLine: 130, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!262 = !DISubprogram(name: "swap", linkageName: "_ZNSt15__exception_ptr13exception_ptr4swapERS0_", scope: !221, file: !222, line: 133, type: !263, scopeLine: 133, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!263 = !DISubroutineType(types: !264)
!264 = !{null, !229, !257}
!265 = !DISubprogram(name: "operator bool", linkageName: "_ZNKSt15__exception_ptr13exception_ptrcvbEv", scope: !221, file: !222, line: 145, type: !266, scopeLine: 145, flags: DIFlagPublic | DIFlagExplicit | DIFlagPrototyped, spFlags: 0)
!266 = !DISubroutineType(types: !267)
!267 = !{!268, !237}
!268 = !DIBasicType(name: "bool", size: 8, encoding: DW_ATE_boolean)
!269 = !DISubprogram(name: "__cxa_exception_type", linkageName: "_ZNKSt15__exception_ptr13exception_ptr20__cxa_exception_typeEv", scope: !221, file: !222, line: 154, type: !270, scopeLine: 154, flags: DIFlagPublic | DIFlagPrototyped, spFlags: 0)
!270 = !DISubroutineType(types: !271)
!271 = !{!272, !237}
!272 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !273, size: 64)
!273 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !274)
!274 = !DICompositeType(tag: DW_TAG_class_type, name: "type_info", scope: !10, file: !275, line: 88, flags: DIFlagFwdDecl)
!275 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/10/../../../../include/c++/10/typeinfo", directory: "")
!276 = !DIImportedEntity(tag: DW_TAG_imported_declaration, scope: !223, entity: !277, file: !222, line: 74)
!277 = !DISubprogram(name: "rethrow_exception", linkageName: "_ZSt17rethrow_exceptionNSt15__exception_ptr13exception_ptrE", scope: !10, file: !222, line: 70, type: !278, flags: DIFlagPrototyped | DIFlagNoReturn, spFlags: 0)
!278 = !DISubroutineType(types: !279)
!279 = !{null, !221}
!280 = !{i32 7, !"Dwarf Version", i32 4}
!281 = !{i32 2, !"Debug Info Version", i32 3}
!282 = !{i32 1, !"wchar_size", i32 4}
!283 = !{!"clang version 10.0.0-4ubuntu1 "}
!284 = distinct !DISubprogram(name: "getmax", linkageName: "_Z6getmaxii", scope: !1, file: !1, line: 7, type: !285, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!285 = !DISubroutineType(types: !286)
!286 = !{!5, !5, !5}
!287 = !DILocalVariable(name: "a", arg: 1, scope: !284, file: !1, line: 7, type: !5)
!288 = !DILocation(line: 7, column: 16, scope: !284)
!289 = !DILocalVariable(name: "b", arg: 2, scope: !284, file: !1, line: 7, type: !5)
!290 = !DILocation(line: 7, column: 23, scope: !284)
!291 = !DILocation(line: 9, column: 12, scope: !284)
!292 = !DILocation(line: 9, column: 16, scope: !284)
!293 = !DILocation(line: 9, column: 14, scope: !284)
!294 = !DILocation(line: 9, column: 5, scope: !284)
!295 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !129, scopeLine: 13, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!296 = !DILocalVariable(name: "a", scope: !295, file: !1, line: 14, type: !5)
!297 = !DILocation(line: 14, column: 9, scope: !295)
!298 = !DILocalVariable(name: "b", scope: !295, file: !1, line: 14, type: !5)
!299 = !DILocation(line: 14, column: 12, scope: !295)
!300 = !DILocalVariable(name: "c", scope: !295, file: !1, line: 14, type: !5)
!301 = !DILocation(line: 14, column: 15, scope: !295)
!302 = !DILocalVariable(name: "d", scope: !295, file: !1, line: 14, type: !5)
!303 = !DILocation(line: 14, column: 18, scope: !295)
!304 = !DILocation(line: 16, column: 24, scope: !295)
!305 = !DILocation(line: 16, column: 5, scope: !295)
!306 = !DILocation(line: 17, column: 28, scope: !295)
!307 = !DILocation(line: 17, column: 52, scope: !295)
!308 = !DILocation(line: 17, column: 55, scope: !295)
!309 = !DILocation(line: 17, column: 5, scope: !295)
!310 = !DILocation(line: 18, column: 28, scope: !295)
!311 = !DILocation(line: 18, column: 57, scope: !295)
!312 = !DILocation(line: 18, column: 60, scope: !295)
!313 = !DILocation(line: 18, column: 5, scope: !295)
!314 = !DILocation(line: 19, column: 28, scope: !295)
!315 = !DILocation(line: 19, column: 57, scope: !295)
!316 = !DILocation(line: 19, column: 60, scope: !295)
!317 = !DILocation(line: 19, column: 5, scope: !295)
!318 = !DILocation(line: 21, column: 9, scope: !319)
!319 = distinct !DILexicalBlock(scope: !295, file: !1, line: 21, column: 9)
!320 = !DILocation(line: 21, column: 13, scope: !319)
!321 = !DILocation(line: 21, column: 11, scope: !319)
!322 = !DILocation(line: 0, scope: !319)
!323 = !DILocation(line: 21, column: 9, scope: !295)
!324 = !DILocation(line: 23, column: 15, scope: !325)
!325 = distinct !DILexicalBlock(scope: !319, file: !1, line: 22, column: 5)
!326 = !DILocation(line: 23, column: 11, scope: !325)
!327 = !DILocation(line: 24, column: 13, scope: !325)
!328 = !DILocation(line: 24, column: 15, scope: !325)
!329 = !DILocation(line: 24, column: 11, scope: !325)
!330 = !DILocation(line: 25, column: 5, scope: !325)
!331 = !DILocation(line: 26, column: 18, scope: !332)
!332 = distinct !DILexicalBlock(scope: !319, file: !1, line: 26, column: 14)
!333 = !DILocation(line: 26, column: 16, scope: !332)
!334 = !DILocation(line: 26, column: 14, scope: !319)
!335 = !DILocation(line: 28, column: 13, scope: !336)
!336 = distinct !DILexicalBlock(scope: !332, file: !1, line: 27, column: 5)
!337 = !DILocation(line: 28, column: 15, scope: !336)
!338 = !DILocation(line: 28, column: 11, scope: !336)
!339 = !DILocation(line: 29, column: 13, scope: !336)
!340 = !DILocation(line: 29, column: 15, scope: !336)
!341 = !DILocation(line: 29, column: 11, scope: !336)
!342 = !DILocation(line: 30, column: 5, scope: !336)
!343 = !DILocation(line: 33, column: 20, scope: !344)
!344 = distinct !DILexicalBlock(scope: !332, file: !1, line: 32, column: 5)
!345 = !DILocation(line: 33, column: 23, scope: !344)
!346 = !DILocation(line: 33, column: 13, scope: !344)
!347 = !DILocation(line: 33, column: 11, scope: !344)
!348 = !DILocation(line: 34, column: 20, scope: !344)
!349 = !DILocation(line: 34, column: 23, scope: !344)
!350 = !DILocation(line: 34, column: 13, scope: !344)
!351 = !DILocation(line: 34, column: 11, scope: !344)
!352 = !DILocation(line: 37, column: 9, scope: !353)
!353 = distinct !DILexicalBlock(scope: !295, file: !1, line: 37, column: 9)
!354 = !DILocation(line: 37, column: 11, scope: !353)
!355 = !DILocation(line: 37, column: 19, scope: !353)
!356 = !DILocation(line: 37, column: 21, scope: !353)
!357 = !DILocation(line: 37, column: 16, scope: !353)
!358 = !DILocation(line: 39, column: 13, scope: !359)
!359 = distinct !DILexicalBlock(scope: !353, file: !1, line: 38, column: 5)
!360 = !DILocation(line: 39, column: 15, scope: !359)
!361 = !DILocation(line: 39, column: 11, scope: !359)
!362 = !DILocation(line: 40, column: 20, scope: !359)
!363 = !DILocation(line: 40, column: 23, scope: !359)
!364 = !DILocation(line: 40, column: 13, scope: !359)
!365 = !DILocation(line: 40, column: 11, scope: !359)
!366 = !DILocation(line: 41, column: 5, scope: !359)
!367 = !DILocation(line: 43, column: 9, scope: !368)
!368 = distinct !DILexicalBlock(scope: !295, file: !1, line: 43, column: 9)
!369 = !DILocation(line: 43, column: 11, scope: !368)
!370 = !DILocation(line: 43, column: 9, scope: !295)
!371 = !DILocation(line: 45, column: 11, scope: !372)
!372 = distinct !DILexicalBlock(scope: !368, file: !1, line: 44, column: 5)
!373 = !DILocation(line: 46, column: 5, scope: !372)
!374 = !DILocation(line: 48, column: 5, scope: !295)
!375 = distinct !DISubprogram(name: "make_pse_symbolic<int>", linkageName: "_Z17make_pse_symbolicIiEvPvmPKcOT_S4_", scope: !376, file: !376, line: 7, type: !377, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, templateParams: !380, retainedNodes: !2)
!376 = !DIFile(filename: "./PSE.h", directory: "/home/ha-useast-service/Documents/Research/PSE-Program-Examples")
!377 = !DISubroutineType(types: !378)
!378 = !{null, !37, !38, !53, !379, !379}
!379 = !DIDerivedType(tag: DW_TAG_rvalue_reference_type, baseType: !5, size: 64)
!380 = !{!381}
!381 = !DITemplateTypeParameter(name: "T", type: !5)
!382 = !DILocalVariable(name: "addr", arg: 1, scope: !375, file: !376, line: 7, type: !37)
!383 = !DILocation(line: 7, column: 30, scope: !375)
!384 = !DILocalVariable(name: "bytes", arg: 2, scope: !375, file: !376, line: 7, type: !38)
!385 = !DILocation(line: 7, column: 43, scope: !375)
!386 = !DILocalVariable(name: "name", arg: 3, scope: !375, file: !376, line: 7, type: !53)
!387 = !DILocation(line: 7, column: 62, scope: !375)
!388 = !DILocalVariable(name: "min_elem", arg: 4, scope: !375, file: !376, line: 7, type: !379)
!389 = !DILocation(line: 7, column: 72, scope: !375)
!390 = !DILocalVariable(name: "max_elem", arg: 5, scope: !375, file: !376, line: 7, type: !379)
!391 = !DILocation(line: 7, column: 86, scope: !375)
!392 = !DILocation(line: 9, column: 24, scope: !375)
!393 = !DILocation(line: 9, column: 30, scope: !375)
!394 = !DILocation(line: 9, column: 37, scope: !375)
!395 = !DILocation(line: 9, column: 5, scope: !375)
!396 = !DILocation(line: 10, column: 23, scope: !375)
!397 = !DILocation(line: 10, column: 18, scope: !375)
!398 = !DILocation(line: 10, column: 17, scope: !375)
!399 = !DILocation(line: 10, column: 40, scope: !375)
!400 = !DILocation(line: 10, column: 50, scope: !375)
!401 = !DILocation(line: 10, column: 31, scope: !375)
!402 = !DILocation(line: 10, column: 28, scope: !375)
!403 = !DILocation(line: 10, column: 5, scope: !375)
!404 = !DILocation(line: 11, column: 23, scope: !375)
!405 = !DILocation(line: 11, column: 18, scope: !375)
!406 = !DILocation(line: 11, column: 17, scope: !375)
!407 = !DILocation(line: 11, column: 40, scope: !375)
!408 = !DILocation(line: 11, column: 50, scope: !375)
!409 = !DILocation(line: 11, column: 31, scope: !375)
!410 = !DILocation(line: 11, column: 28, scope: !375)
!411 = !DILocation(line: 11, column: 5, scope: !375)
!412 = !DILocation(line: 12, column: 1, scope: !375)
!413 = distinct !DISubprogram(name: "min<int>", linkageName: "_ZSt3minIiERKT_S2_S2_", scope: !10, file: !414, line: 230, type: !415, scopeLine: 231, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, templateParams: !419, retainedNodes: !2)
!414 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/10/../../../../include/c++/10/bits/stl_algobase.h", directory: "")
!415 = !DISubroutineType(types: !416)
!416 = !{!417, !417, !417}
!417 = !DIDerivedType(tag: DW_TAG_reference_type, baseType: !418, size: 64)
!418 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !5)
!419 = !{!420}
!420 = !DITemplateTypeParameter(name: "_Tp", type: !5)
!421 = !DILocalVariable(name: "__a", arg: 1, scope: !413, file: !422, line: 420, type: !417)
!422 = !DIFile(filename: "/usr/bin/../lib/gcc/x86_64-linux-gnu/10/../../../../include/c++/10/bits/algorithmfwd.h", directory: "")
!423 = !DILocation(line: 420, column: 19, scope: !413)
!424 = !DILocalVariable(name: "__b", arg: 2, scope: !413, file: !422, line: 420, type: !417)
!425 = !DILocation(line: 420, column: 31, scope: !413)
!426 = !DILocation(line: 235, column: 11, scope: !427)
!427 = distinct !DILexicalBlock(scope: !413, file: !414, line: 235, column: 11)
!428 = !DILocation(line: 235, column: 17, scope: !427)
!429 = !DILocation(line: 235, column: 15, scope: !427)
!430 = !DILocation(line: 235, column: 11, scope: !413)
!431 = !DILocation(line: 236, column: 9, scope: !427)
!432 = !DILocation(line: 236, column: 2, scope: !427)
!433 = !DILocation(line: 237, column: 14, scope: !413)
!434 = !DILocation(line: 237, column: 7, scope: !413)
!435 = !DILocation(line: 238, column: 5, scope: !413)
!436 = distinct !DISubprogram(name: "max<int>", linkageName: "_ZSt3maxIiERKT_S2_S2_", scope: !10, file: !414, line: 254, type: !415, scopeLine: 255, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, templateParams: !419, retainedNodes: !2)
!437 = !DILocalVariable(name: "__a", arg: 1, scope: !436, file: !422, line: 407, type: !417)
!438 = !DILocation(line: 407, column: 19, scope: !436)
!439 = !DILocalVariable(name: "__b", arg: 2, scope: !436, file: !422, line: 407, type: !417)
!440 = !DILocation(line: 407, column: 31, scope: !436)
!441 = !DILocation(line: 259, column: 11, scope: !442)
!442 = distinct !DILexicalBlock(scope: !436, file: !414, line: 259, column: 11)
!443 = !DILocation(line: 259, column: 17, scope: !442)
!444 = !DILocation(line: 259, column: 15, scope: !442)
!445 = !DILocation(line: 259, column: 11, scope: !436)
!446 = !DILocation(line: 260, column: 9, scope: !442)
!447 = !DILocation(line: 260, column: 2, scope: !442)
!448 = !DILocation(line: 261, column: 14, scope: !436)
!449 = !DILocation(line: 261, column: 7, scope: !436)
!450 = !DILocation(line: 262, column: 5, scope: !436)
