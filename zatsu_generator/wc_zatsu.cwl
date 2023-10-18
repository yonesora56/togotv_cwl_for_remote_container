#!/usr/bin/env cwl-runner
# Generated from: wc -l grep_out.txt > wc_out.txt
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [wc, -l] #baseCommandに -lオプションを記載
arguments:
  - $(inputs.grep_file)
inputs:
  - id: grep_file
    type: File
    default:
      class: File
      basename: "grepout.txt"
      contents: "This is a text file."
      path: ./grepout.txt # pathフィールドを追加
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: out
    type: stdout
stdout: wc_out.txt