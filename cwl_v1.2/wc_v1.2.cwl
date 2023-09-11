cwlVersion: v1.2
class: CommandLineTool
baseCommand: [wc, -l]
inputs:
  file:
    type: File
    inputBinding:
      position: 1
  wc_file_name: # 参考：https://github.com/ncbi/pgap/blob/master/progs/cat.cwl
    type: string
    default: wc_out.txt
outputs:
  word_counts: 
    type: File
    outputBinding:
      glob: "$(inputs.wc_file_name)"
stdout: $(inputs.wc_file_name) 

