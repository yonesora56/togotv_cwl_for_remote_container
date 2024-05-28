cwlVersion: v1.2
class: Workflow
inputs:
  grep_pattern:
    type: string
  target_file:
    type: File
outputs:
  counts:
    type: File
    outputSource: 2_wc_v1.2/word_counts

# 先にステップを書く→outputsを書くの順番のほうがやりやすい?
steps: 
  1_grep_v1.2:
    run: grep_v1.2.cwl
    in:
      pattern: grep_pattern
      file_to_search: target_file
    out: [results]
  2_wc_v1.2:
    run: wc_v1.2.cwl
    in:
      file: 1_grep_v1.2/results
    out:
      [word_counts]
