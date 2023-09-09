cwlVersion: v1.0
class: CommandLineTool
baseCommand: grep
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
outputs: 
  results:
    type: stdout
stdout: grep_out.txt # > grep_out.txtの部分 カレントディレクトリに出力