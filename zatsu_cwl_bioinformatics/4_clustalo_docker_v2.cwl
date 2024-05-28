#!/usr/bin/env cwl-runner
# Generated from: clustalo -i blastdbcmd_result.fasta --outfmt=fasta -o clustalo_result.fasta
class: CommandLineTool
cwlVersion: v1.0
baseCommand: clustalo
arguments:
  - -i
  - $(inputs.i)
  - --outfmt=fasta
  - -o
  - $(inputs.o_name)
inputs:
  - id: i
    type: File
    default:
      class: File
      location: blastdbcmd_result.fasta
  - id: o_name
    type: string
    default: clustalo_result.fasta
outputs:
  - id: clustalo_result
    type: File
    outputBinding:
      glob: "*"
#  - id: o
#    type: File
#    outputBinding:
#      glob: "$(inputs.o_name)"
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/clustalo:v1.2.4-2-deb_cv1
