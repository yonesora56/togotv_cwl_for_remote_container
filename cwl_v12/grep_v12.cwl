cwlVersion: v1.2
class: CommandLineTool
baseCommand: [grep]
# インデントに注意!
inputs:
  pattern: # 自分で自由につけていい部分
    type: string # パターンを検索するための文字列
    inputBinding:
      position: 1 # 引数のポジション (0か1か細かい所だけど聞いてみる)
  file_to_search: # 自分で自由につけていい部分
    type: File
    inputBinding:
      position: 2 # 引数のポジション
  output_file_name: # 参考：https://github.com/ncbi/pgap/blob/master/progs/cat.cwl
    type: string
    default: grep_out.txt
outputs: 
  results:
    type: File #ここは直接stdoutではなく､Fileなどの種類を書く
    outputBinding:
      glob: "$(inputs.output_file_name)" #出力を認識 ""でくくる
stdout: $(inputs.output_file_name) # > grep_out.txtの部分 カレントディレクトリに出力