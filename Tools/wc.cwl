cwlVersion: v1.0
class: CommandLineTool
baseCommand: [wc, -l]
inputs:
  file:
    type: File
    inputBinding:
      position: 1
outputs:
  word_counts: stdout
stdout: wc_out.txt
