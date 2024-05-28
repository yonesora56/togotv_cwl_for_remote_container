#!/usr/bin/env cwl-runner
cwlVersion: v1.0
class: Workflow
doc: "blastp, awk, blastdbcmd, clustalo, and fasttreeの5つのステップを実行"

inputs:
  - id: 1_protein_query
    type: File
    doc: "blastp process input protein query file(fasta format)"
    default:
      class: File
      location: ./MSTN.fasta
  - id: 2_protein_database
    type: File
    doc: "blastp process input all index file"
    default:
      class: File
      location: ./uniprot_sprot.fasta
    secondaryFiles:
      - ^.fasta.phd
      - ^.fasta.phi
      - ^.fasta.phr
      - ^.fasta.pin
      - ^.fasta.pog
      - ^.fasta.psd
      - ^.fasta.psi
      - ^.fasta.psq
  - id: 3_evalue
    type: float
    doc: "blastp process evalue cutoff"
    default: 0.01
  - id: 4_number_of_threads
    type: int
    doc: "number of threads"
    default: 8
  - id: 5_outformat_type
    type: int
    doc: "blastp process output format type"
    default: 6
  - id: 6_output_file_name
    type: string
    doc: "blastp process output file name"
    default: blastp_output.txt
  - id: 7_max_target_sequence
    type: int
    doc: "blastp process max target sequence"
    default: 20
  - id: 8_blastdbcmd_protein_database
    type: File
    doc: "blastdbcmd process protein database"
    default:
      class: File
      location: ./uniprot_sprot.fasta
    secondaryFiles:
      - ^.fasta.phd
      - ^.fasta.phi
      - ^.fasta.phr
      - ^.fasta.pin
      - ^.fasta.pog
      - ^.fasta.psd
      - ^.fasta.psi
      - ^.fasta.psq
  - id: 10_clustalo_output_name
    type: string
    doc: "clustalo process output name"
    default: clustalo_output.fasta

steps:
  step1_blastp:
    run: 1_blastp_docker_v5.cwl
    in: 
      query: 1_protein_query
      db: 2_protein_database
      evalue: 3_evalue
      num_threads: 4_number_of_threads
      outfmt: 5_outformat_type
      out: 6_output_file_name
      max_target_seqs: 7_max_target_sequence
    out: [blastp_result]

  step2_awk:
    run: 2_awk_v2.cwl
    in:
      blastp_result: step1_blastp/blastp_result
    out: [out]
  
  step3_blastdbcmd:
    run: 3_blastdbcmd_docker_v3.cwl
    in:
      db: 8_blastdbcmd_protein_database
      entry_batch: step2_awk/out
    out: [blastdbcmd_result]

  step4_clustalo:
    run: 4_clustalo_docker_v2.cwl
    in: 
      i: step3_blastdbcmd/blastdbcmd_result
      o_name: 10_clustalo_output_name
    out: [clustalo_result]

  step5_fasttree:
    run: 5_fasttree_docker.cwl
    in:
      nt: step4_clustalo/clustalo_result
    out: [out]

outputs:
  final_output_bootstrap:
    type: File
    doc: "final output file"
    outputSource: step5_fasttree/out

      

    
    

