; ModuleID = 'test4.ll'
source_filename = "test4.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @__coverage__(i32 5, i32 7)
  call void @llvm.dbg.declare(metadata i32* %i, metadata !11, metadata !DIExpression()), !dbg !12
  call void @__coverage__(i32 6, i32 7)
  call void @llvm.dbg.declare(metadata i32* %x, metadata !13, metadata !DIExpression()), !dbg !14
  call void @__coverage__(i32 6, i32 7)
  store i32 0, i32* %x, align 4, !dbg !14
  call void @__coverage__(i32 7, i32 7)
  call void @llvm.dbg.declare(metadata i32* %y, metadata !15, metadata !DIExpression()), !dbg !16
  call void @__coverage__(i32 7, i32 7)
  store i32 2, i32* %y, align 4, !dbg !16
  call void @__coverage__(i32 8, i32 6)
  call void @llvm.dbg.declare(metadata i32* %z, metadata !17, metadata !DIExpression()), !dbg !18
  call void @__coverage__(i32 9, i32 2)
  br label %while.cond, !dbg !19

while.cond:                                       ; preds = %if.end, %entry
  call void @__coverage__(i32 9, i32 14)
  %call = call i32 @getchar(), !dbg !20
  call void @__coverage__(i32 9, i32 12)
  store i32 %call, i32* %i, align 4, !dbg !21
  call void @__coverage__(i32 9, i32 25)
  %sub = sub nsw i32 %call, 48, !dbg !22
  call void @__coverage__(i32 9, i32 31)
  %cmp = icmp sge i32 %sub, 0, !dbg !23
  call void @__coverage__(i32 9, i32 2)
  br i1 %cmp, label %while.body, label %while.end, !dbg !19

while.body:                                       ; preds = %while.cond
  call void @__coverage__(i32 10, i32 9)
  %0 = load i32, i32* %i, align 4, !dbg !24
  call void @__coverage__(i32 10, i32 11)
  %cmp1 = icmp eq i32 %0, 121, !dbg !27
  call void @__coverage__(i32 10, i32 9)
  br i1 %cmp1, label %if.then, label %if.end, !dbg !28

if.then:                                          ; preds = %while.body
  call void @__coverage__(i32 11, i32 11)
  %1 = load i32, i32* %y, align 4, !dbg !29
  call void @__coverage__(i32 11, i32 15)
  %2 = load i32, i32* %x, align 4, !dbg !31
  call void @__sanitize__(i32 %2, i32 11, i32 13)
  call void @__coverage__(i32 11, i32 13)
  %div = sdiv i32 %1, %2, !dbg !32
  call void @__coverage__(i32 11, i32 9)
  store i32 %div, i32* %z, align 4, !dbg !33
  call void @__coverage__(i32 12, i32 3)
  br label %if.end, !dbg !34

if.end:                                           ; preds = %if.then, %while.body
  call void @__coverage__(i32 9, i32 2)
  br label %while.cond, !dbg !19, !llvm.loop !35

while.end:                                        ; preds = %while.cond
  call void @__coverage__(i32 14, i32 3)
  ret i32 0, !dbg !37
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @getchar() #2

declare void @__coverage__(i32, i32)

declare void @__sanitize__(i32, i32, i32)

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.1- (branches/release_80)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "test4.c", directory: "/lab4/test")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.1- (branches/release_80)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 4, type: !8, scopeLine: 4, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 5, type: !10)
!12 = !DILocation(line: 5, column: 7, scope: !7)
!13 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 6, type: !10)
!14 = !DILocation(line: 6, column: 7, scope: !7)
!15 = !DILocalVariable(name: "y", scope: !7, file: !1, line: 7, type: !10)
!16 = !DILocation(line: 7, column: 7, scope: !7)
!17 = !DILocalVariable(name: "z", scope: !7, file: !1, line: 8, type: !10)
!18 = !DILocation(line: 8, column: 6, scope: !7)
!19 = !DILocation(line: 9, column: 2, scope: !7)
!20 = !DILocation(line: 9, column: 14, scope: !7)
!21 = !DILocation(line: 9, column: 12, scope: !7)
!22 = !DILocation(line: 9, column: 25, scope: !7)
!23 = !DILocation(line: 9, column: 31, scope: !7)
!24 = !DILocation(line: 10, column: 9, scope: !25)
!25 = distinct !DILexicalBlock(scope: !26, file: !1, line: 10, column: 9)
!26 = distinct !DILexicalBlock(scope: !7, file: !1, line: 9, column: 37)
!27 = !DILocation(line: 10, column: 11, scope: !25)
!28 = !DILocation(line: 10, column: 9, scope: !26)
!29 = !DILocation(line: 11, column: 11, scope: !30)
!30 = distinct !DILexicalBlock(scope: !25, file: !1, line: 10, column: 19)
!31 = !DILocation(line: 11, column: 15, scope: !30)
!32 = !DILocation(line: 11, column: 13, scope: !30)
!33 = !DILocation(line: 11, column: 9, scope: !30)
!34 = !DILocation(line: 12, column: 3, scope: !30)
!35 = distinct !{!35, !19, !36}
!36 = !DILocation(line: 13, column: 3, scope: !7)
!37 = !DILocation(line: 14, column: 3, scope: !7)
