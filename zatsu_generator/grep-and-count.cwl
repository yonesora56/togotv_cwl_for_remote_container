#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
inputs:
  grep_pattern:
    type: string #文字列
  target_file:
    type: File #ファイル
outputs:
  counts:
    type: File
    outputSource: 2_wc/out
steps:
  1_grep:
    run: grep_zatsu.cwl
    in:
      one: grep_pattern
      mock_txt: target_file
    out: [out]
  2_wc:
    run: wc_zatsu.cwl
    in:
      grep_file: 1_grep/out
    out: [out] 