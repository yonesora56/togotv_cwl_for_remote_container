#!/usr/bin/env cwl-runner
# Generated from: wc -l grepout.txt > wcout.txt
class: CommandLineTool
cwlVersion: v1.0
baseCommand: wc
arguments:
  - -l
  - $(inputs.grep_out)
inputs:
  - id: grep_out
    type: File
    default:
      class: File
      location: ./grepout.txt
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: out
    type: stdout
stdout: wcout.txt
