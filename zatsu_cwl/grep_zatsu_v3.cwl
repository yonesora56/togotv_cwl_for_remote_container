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
    doc: "please input grep pattern Default: one"
  - id: mock_txt
    type: File
    default:
      class: File
      location: mock.txt
    doc: "please input text file Default: ./mock.txt"
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
