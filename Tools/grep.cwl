#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: grep
arguments: [ $(inputs.pattern), $(inputs.file_to_search)]
inputs:
  pattern: 
    type: string
    doc: 文字列を入力してください (例：one)
  file_to_search: #パラメータ2を追加
    type: File
    doc: ファイルをインプットしてください
outputs:  
  results:
    type: stdout
stdout: grep_out.txt 