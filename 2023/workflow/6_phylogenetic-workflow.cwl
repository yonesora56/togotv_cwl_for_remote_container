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
  2_protein_database:
    type: File
    secondaryFiles:
      - ^.fasta.phd
      - ^.fasta.phi
      - ^.fasta.phr
      - ^.fasta.pin
      - ^.fasta.pog
      - ^.fasta.psd
      - ^.fasta.psi
      - ^.fasta.psq
  3_e-value: 
    type: float?
  4_number_of_threads: 
    type: int
  5_outformat_type: 
    type: int
  6_output_file_name: 
    type: string
  7_max_target_sequence: 
    type: int
  #awk
  8_output_id_file_name:
    type: string
  #blastdbcmd
  9_blastdbcmd_protein_database:
    type: File
    secondaryFiles:
      - ^.fasta.phd
      - ^.fasta.phi
      - ^.fasta.phr
      - ^.fasta.pin
      - ^.fasta.pog
      - ^.fasta.psd
      - ^.fasta.psi
      - ^.fasta.psq
  10_blastdbcmd_output_name:
    type: string
  #clustalo
  11_clustalo_format:
    type: string
  12_clustalo_output_name:
    type: string
  #fasttree
  13_fasttree_output_file_name:
    type: string
  

outputs:
  final_output_bootstrap: 
    type: File
    outputSource: step5_fasttree/fasttree_output_file
steps:
  step1_blastp:
    run: ../Tools/1_blastp.cwl 
    in: 
      protein_query: 1_protein_query
      protein_database: 2_protein_database
      evalue: 3_e-value
      number_of_threads: 4_number_of_threads
      outformat_type: 5_outformat_type
      output_file_name: 6_output_file_name
      max_target_sequence: 7_max_target_sequence
    out: [blastp_output_file] 

  step2_awk:
    run: ../Tools/2_awk.cwl
    in:
      blastp_result: step1_blastp/blastp_output_file 
      output_id_file_name: 8_output_id_file_name
    out: [awk_output]

  step3_blastdbcmd:
    run: ../Tools/3_blastdbcmd.cwl
    in: 
      blastdbcmd_protein_database: 9_blastdbcmd_protein_database
      id_query: step2_awk/awk_output 
      blastdbcmd_output_name: 10_blastdbcmd_output_name
    out: [blastdbcmd_output]

  step4_clustalo:
    run: ../Tools/4_clustalo.cwl
    in:
      clustalo_inputs: step3_blastdbcmd/blastdbcmd_output
      clustalo_format: 11_clustalo_format
      clustalo_output_name: 12_clustalo_output_name
    out: [clustalo_output]

  step5_fasttree:
    run: ../Tools/5_fasttree.cwl
    in:
      fasttree_output_file_name: 13_fasttree_output_file_name
      fasttree_input_file: step4_clustalo/clustalo_output
    out: [fasttree_output_file]
