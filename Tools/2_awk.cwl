#!/usr/bin/env cwl-runner
# Generated from: docker run --rm -it -v `pwd`:`pwd` -w `pwd` ubuntu:23.10 awk '{ print $2 }' blastp_result_MSTN.txt > blastp_result_id.txt
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [awk]
doc: Extract hit IDs from BLASTp results

requirements:
  DockerRequirement:
    dockerPull: "ubuntu:23.10"

# 固定の引数
arguments:
  - valueFrom: '{ print $2 }' 
    position: 1

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
