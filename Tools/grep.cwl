#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: CommandLineTool
baseCommand: grep
inputs:
  pattern: 
    type: string 
    inputBinding:
      position: 1 
  file_to_search: 
    type: File
    inputBinding:
      position: 2 
outputs: 
  results:
    type: stdout
stdout: grep_out.txt 