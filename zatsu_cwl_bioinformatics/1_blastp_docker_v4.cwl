#!/usr/bin/env cwl-runner
# Generated from: blastp -query MSTN.fasta -db uniprot_sprot.fasta -evalue 1e-5 -num_threads 4 -outfmt 6 -out blastp_result.txt -max_target_seqs 20
class: CommandLineTool
cwlVersion: v1.0
baseCommand: blastp
arguments:
  - -query
  - $(inputs.query)
  - -db
  - $(inputs.db)
  - -evalue
  - $(inputs.evalue)
  - -num_threads
  - $(inputs.num_threads)
  - -outfmt
  - $(inputs.outfmt)
  - -out
  - $(inputs.out)
  - -max_target_seqs
  - $(inputs.max_target_seqs)
inputs:
  - id: query
    type: File
    default:
      class: File
      location: MSTN.fasta
  - id: db
    type: File
    default:
      class: File
      location: ./uniprot_sprot.fasta
    secondaryFiles: # ここを追加する
      - ^.fasta.phd
      - ^.fasta.phi
      - ^.fasta.phr
      - ^.fasta.pin
      - ^.fasta.pog
      - ^.fasta.psd
      - ^.fasta.psi
      - ^.fasta.psq
  - id: evalue
    type: float
    default: 1e-5
  - id: num_threads
    type: int
    default: 4
  - id: outfmt
    type: int
    default: 6
  - id: out
    type: string # Fileではなくstringにする
    default: blastp_result.txt
  - id: max_target_seqs
    type: int
    default: 20
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/blast:v2.2.31_cv2
