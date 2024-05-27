#!/usr/bin/env cwl-runner
# Generated from: grep one mock.txt > grepout.txt
class: CommandLineTool
cwlVersion: v1.0
baseCommand: grep
arguments:
  - $(inputs.one)
  - $(inputs.mock_txt)
inputs:
  - id: one
    type: string
    default: one
  - id: mock_txt
    type: File
    doc: please input text file #記載をここに追加
    default:
      class: File
      location: mock.txt
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: out
    type: stdout
stdout: grepout.txt
