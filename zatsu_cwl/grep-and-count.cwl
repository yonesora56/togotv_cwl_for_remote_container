#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
inputs:
  grep_pattern: #このワークフロー全体のインプット(1)
    type: string
  target_file: #このワークフロー全体のインプット(2)
    type: File
outputs: # このワークフロー全体の出力としてgrepの結果も得たい場合､outputsフィールドに記入する
  grep_result: #このワークフロー全体のアウトプット(1)
    type: File
    outputSource: 1_grep/out
  counts: #このワークフロー全体のアウトプット(2)
    type: File
    outputSource: 2_wc/out
steps:
  1_grep:
    run: grep_zatsu_v3.cwl
    in:
      one: grep_pattern #(左)grep_zatsu.cwlのinput: (右)このワークフローのinput
      mock_txt: target_file
    out: [out]
  2_wc:
    run: wc_zatsu_v2.cwl
    in:
      grep_out: 1_grep/out
    out: [out] 


