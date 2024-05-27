#!/usr/bin/env cwl-runner
# Generated from: awk '{ print  }' blastp_result.txt > blastp_result_id.txt
class: CommandLineTool
cwlVersion: v1.0
baseCommand: awk
arguments: # argumentsを追加
  - valueFrom: '{ print $2 }'
    position: 1
inputs:
  - id: blastp_result
    type: File
    default:
      class: File
      location: ./blastp_result.txt
    inputBinding:
      position: 2 # positionを追加
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: out
    type: stdout
stdout: blastp_result_id.txt
