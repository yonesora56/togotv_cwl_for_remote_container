#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: grep
arguments: [ $(inputs.pattern), $(inputs.file_to_search)]
inputs:
  pattern:
    type: string
    doc: "please enter a string (example: one)"
  file_to_search: 
    type: File
    doc: please input file
outputs:  
  results:
    type: stdout
stdout: grep_out.txt 