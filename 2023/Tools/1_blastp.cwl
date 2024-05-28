#!/usr/bin/env cwl-runner
# Generated from: docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/blast:v2.2.31_cv2 blastp -query MSTN.fasta -db uniprot_sprot.fasta -evalue 1e-5 -num_threads 4 -outfmt 6 -out blastp_result_MSTN.txt -max_target_seqs 20
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [blastp]
doc: BLASTP step 


hints: #requirementsではなく､hintsフィールドだと､'記述があった場合に使用する'という方法になるので柔軟になる
  DockerRequirement:
    dockerPull: "biocontainers/blast:v2.2.31_cv2"

arguments:
  - $(inputs.protein_query)
  - $(inputs.protein_database)
  - $(inputs.evalue)
  - $(inputs.number_of_threads)
  - $(inputs.outformat_type)
  - $(inputs.output_file_name)
  - $(inputs.max_target_sequence) 

# input
inputs:
  protein_query:
    type: File
    inputBinding:
      prefix: "-query"
      position: 1
    default:
      class: File
      path: ../data/MSTN.fasta
  protein_database:
    type: File
    default: 
      class: File
      path: ../data/uniprot_sprot.fasta
    inputBinding:
      prefix: "-db"
      position: 2
    secondaryFiles:
      - ^.fasta.phd
      - ^.fasta.phi
      - ^.fasta.phr
      - ^.fasta.pin
      - ^.fasta.pog
      - ^.fasta.psd
      - ^.fasta.psi
      - ^.fasta.psq

  evalue:
    type: float?
    default: 1e-5
    inputBinding:
      prefix: "-evalue"
      position: 3
  number_of_threads:
    type: int
    default: 4
    inputBinding:
      prefix: "-num_threads"
      position: 4
  outformat_type:
    type: int
    default: 6
    inputBinding:
      prefix: "-outfmt"
      position: 5
  output_file_name:
    type: string
    inputBinding:
      prefix: "-out"
      position: 6
    default: blastp_result.txt
  max_target_sequence:
    type: int
    default: 20
    inputBinding:
      prefix: "-max_target_seqs"
      position: 7

outputs:
  blastp_output_file:
    type: File
    outputBinding:
      glob: "$(inputs.output_file_name)"
