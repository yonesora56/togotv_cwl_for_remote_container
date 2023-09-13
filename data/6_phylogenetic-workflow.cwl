#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
doc: "5つのステップを実行するワークフロー: blastp, awk, blastdbcmd, clustalo, and fasttree"
#最初のインプットのみ記述しようと思ったが､全部書いてわかりやすく書く方針に
# 前のステップの出力の書き方に注意
inputs: 
  #blastp
  1_protein_query: 
    type: File
  2_protein_database_directory:
    type: Directory?
  3_protein_database_name: 
    type: string
  4_e-value: 
    type: float?
  5_number_of_threads: 
    type: int
  6_outformat_type: 
    type: int
  7_output_file_name: 
    type: string
  8_max_target_sequence: 
    type: int
  #awk
  9_output_id_file_name:
    type: string
  #blastdbcmd
  10_blastdbcmd_protein_database_directory:
    type: Directory?
  11_blastdbcmd_protein_database_name:
    type: string
  12_blastdbcmd_output_name:
    type: string
  #clustalo
  13_clustalo_format:
    type: string
  14_clustalo_output_name:
    type: string
  #fasttree
  15_fasttree_output_file_name:
    type: string
  

outputs:
  final_output_bootstrap: 
    type: File
    outputSource: step5_fasttree/fasttree_output_file
steps:
  step1_blastp:
    run: 1_blastp.cwl #同じディレクトリにあるか確認
    in: #workflow全体のインプットにつながる
      protein_query: 1_protein_query
      protein_database_directory: 2_protein_database_directory
      protein_database_name: 3_protein_database_name
      e-value: 4_e-value
      number_of_threads: 5_number_of_threads
      outformat_type: 6_outformat_type
      output_file_name: 7_output_file_name
      max_target_sequence: 8_max_target_sequence
    out: [blastp_output_file] #1_blastp.cwlで記述したoutput

  step2_awk:
    run: 2_awk.cwl
    in:
      blastp_result: step1_blastp/blastp_output_file #1_blastp.cwlで記述したoutput ここがこんがらがるので注意
      output_id_file_name: 9_output_id_file_name
    out: [awk_output]

  step3_blastdbcmd:
    run: 3_blastdbcmd.cwl
    in: 
      blastdbcmd_protein_database_directory: 10_blastdbcmd_protein_database_directory
      blastdbcmd_protein_database_name: 11_blastdbcmd_protein_database_name
      id_query: step2_awk/awk_output #ここは前のステップの出力
      blastdbcmd_output_name: 12_blastdbcmd_output_name
    out: [blastdbcmd_output]

  step4_clustalo:
    run: 4_clustalo.cwl
    in:
      clustalo_inputs: step3_blastdbcmd/blastdbcmd_output
      clustalo_format: 13_clustalo_format
      clustalo_output_name: 14_clustalo_output_name
    out: [clustalo_output]

  step5_fasttree:
    run: 5_fasttree.cwl
    in:
      fasttree_output_file_name: 15_fasttree_output_file_name
      fasttree_input_file: step4_clustalo/clustalo_output
    out: [fasttree_output_file]
