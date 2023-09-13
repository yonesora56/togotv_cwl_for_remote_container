#!/usr/bin/env cwl-runner
# Generated from: docker run --rm -it -v /workspaces/togotv_shooting/data:/workspaces/togotv_shooting/data  -w  /workspaces/togotv_shooting/data biocontainers/blast:v2.2.31_cv2 blastdbcmd -db uniprot_sprot.fasta -entry_batch blastp_result_id.txt  -out blastp_results_MSTN.fasta
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [blastdbcmd]
doc: blastdbcmdで抜き出してきたIDをもとにタンパク質を検索する

requirements:
  DockerRequirement:
    dockerPull: "biocontainers/blast:v2.2.31_cv2"
  InlineJavascriptRequirement: {} # Javascriptの式を使わせるためにここの部分が必要らしい
  InitialWorkDirRequirement:
    listing:
      - entry: $(inputs.blastdbcmd_protein_database_directory)
        writable: False

# Inputs
inputs:
  blastdbcmd_protein_database_directory: #ここが難しい? けど例はたくさんあるので参考にする
    type: Directory?
  blastdbcmd_protein_database_name:
    type: string?
    default: "uniprot_sprot.fasta"
    inputBinding:
      prefix: "-db"
      position: 1
      # もし入力されていなかったらカレントディレクトリのデータベースを使用するという構文
      # YAMLのparser? が混乱してしまうということで､""でくくった
      valueFrom: "${ return inputs.blastdbcmd_protein_database_directory ? inputs.blastdbcmd_protein_database_directory.path + '/' + inputs.blastdbcmd_protein_database_name : './' + inputs.blastdbcmd_protein_database_name; }"
  id_query:
    type: File
    inputBinding:
      prefix: "-entry_batch"
      position: 2
  blastdbcmd_output_name:
    type: string
    inputBinding:
      prefix: "-out"
      position: 3

#Outputs
outputs:
  blastdbcmd_output:
    type: File
    outputBinding:
      glob: "$(inputs.blastdbcmd_output_name)"
