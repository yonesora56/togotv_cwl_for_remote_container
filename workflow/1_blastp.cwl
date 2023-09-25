#!/usr/bin/env cwl-runner
# Generated from: docker run --rm -it -v `pwd`:`pwd` -w `pwd` biocontainers/blast:v2.2.31_cv2 blastp -query MSTN.fasta -db uniprot_sprot.fasta -evalue 1e-5 -num_threads 4 -outfmt 6 -out blastp_result_MSTN.txt -max_target_seqs 20
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [blastp]
doc: BLASTP step 

requirements:
  DockerRequirement:
    dockerPull: "biocontainers/blast:v2.2.31_cv2"

# input
inputs:
  protein_query:
    type: File
    inputBinding:
      prefix: "-query"
      position: 1
  protein_database_directory:
    type: File
    default: "uniprot_sprot.fasta"
    inputBinding:
      prefix: "-db"
      position: 2
    secondaryFiles:
      - ^.phd
      - ^.phi
      - ^.phr
      - ^.pin
      - ^.pog
      - ^.psd
      - ^.psi
      - ^.psq

  e-value:
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
  max_target_sequence:
    type: int
    default: 20
    inputBinding:
      prefix: "-max_target_seqs"
      position: 7

#outputs
outputs:
  blastp_output_file:
    type: File
    outputBinding:
      glob: "$(inputs.output_file_name)"

# stdout
stdout: $(inputs.output_file_name)
