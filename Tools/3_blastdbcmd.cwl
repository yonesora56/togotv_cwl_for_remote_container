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

# Inputs
inputs:
  blastdbcmd_protein_database:
    type: File
    default: "uniprot_sprot.fasta"
    inputBinding:
      prefix: "-db"
      position: 1
    secondaryFiles:
      - ^.phd
      - ^.phi
      - ^.phr
      - ^.pin
      - ^.pog
      - ^.psd
      - ^.psi
      - ^.psq
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
