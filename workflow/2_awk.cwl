#!/usr/bin/env cwl-runner
# Generated from: awk '{ print $2 }' blastp_result_MSTN.txt > blastp_result_id.txt
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [awk]

# 固定の引数
arguments:
  - valueFrom: '{ print $2 }' # "" で囲むとエラーになる shellQuate: false でも駄目だった
    position: 1 # 同じオブジェクト内に配置しなきゃ駄目!! - position とか並列して書いちゃうと駄目

inputs:
  blastp_result:
    type: File
    inputBinding:
      position: 2
  output_id_file_name:
    type: string
    inputBinding:
      position: 3
outputs:
  awk_output:
    type: File
    outputBinding:
      glob: "$(inputs.output_id_file_name)"
stdout: $(inputs.output_id_file_name)