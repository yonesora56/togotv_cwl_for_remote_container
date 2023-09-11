cwlVersion: v1.0
class: Workflow
inputs:
  grep_pattern:
    type: string #文字列
  target_file:
    type: File #ファイル
outputs:
  counts:
    type: File
    outputSource: 2_wc/word_counts # workflow全体の出力として必要
steps:
  1_grep:
    run: grep.cwl
    in:
      pattern: grep_pattern
      file_to_search: target_file
    out: [results]
  2_wc:
    run: wc.cwl
    in:
      file: 1_grep/results
    out: [word_counts] #list形式で指定する：複数出力される場合など､この書き方でのメリットがたくさんある

