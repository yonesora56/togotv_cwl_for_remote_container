#!/usr/bin/env cwl-runner
# Generated from: awk '{ print  }' blastp_result.txt > blastp_result_id.txt
class: CommandLineTool
cwlVersion: v1.0
baseCommand: awk
arguments:
  - $(inputs.'{)
  - $(inputs.print)
  - $(inputs.}')
  - $(inputs.blastp_result_txt)
inputs:
  - id: '{
    type: Any
    default: '{
  - id: print
    type: Any
    default: print
  - id: }'
    type: Any
    default: }'
  - id: blastp_result_txt
    type: File
    default:
      class: File
      location: blastp_result.txt
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
