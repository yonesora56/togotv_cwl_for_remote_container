#!/usr/bin/env cwl-runner
# Generated from: docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/blast:v2.2.31_cv2 blastp -query MSTN.fasta -db uniprot_sprot.fasta -evalue 1e-5 -num_threads 4 -outfmt 6 -out blastp_result_MSTN.txt -max_target_seqs 20
class: CommandLineTool
cwlVersion: v1.0
# baseCommandにパラメータを全て書いてしまうと､変更ができなくなる
# 特定のオプションが必要な時はここに書く
baseCommand: [blastp]
doc: BLASTP.cwlを書いてみた

requirements:
  DockerRequirement:
    dockerPull: "biocontainers/blast:v2.2.31_cv2"

inputs:
  - id: protein_query
    type: File
    inputBinding:
      prefix: "-query"
      position: 1
  - id: protein_database_directory
    type: Directory?
  - id: protein_database_name
    type: string?
    inputBinding:
      prefix: "-db"
      position: 2
      valueFrom: ${ return inputs.protein_database_directory.path + "/" + inputs.protein_database_name; }
  - id: e-value
    type: float?
    default: 1e-5
    inputBinding:
      prefix: "-evalue"
      position: 3
  - id: number_of_threads
    type: int
    default: 4
    inputBinding:
      prefix: "-num_threads"
      position: 4
  - id: outformat_type
    type: int
    default: 6
    inputBinding:
      prefix: "-outfmt"
      position: 5
  - id: output_file_name
    type: string
    inputBinding:
      prefix: "-out"
      position: 6
  - id: max_target_sequence
    type: int
    default: 20
    inputBinding:
      prefix: "-max_target_seqs"
      position: 7

outputs:
  output_file:
    type: stdout
