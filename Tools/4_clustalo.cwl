#!/usr/bin/env cwl-runner
# Generated from: docker run --rm -it -v /workspaces/togotv_shooting/data:/workspaces/togotv_shooting/data -w /workspaces/togotv_shooting/data biocontainers/clustalo:v1.2.4-2-deb_cv1 clustalo -i /workspaces/togotv_shooting/data/blastp_results_MSTN.fasta --outfmt=fasta -o MSTN_aligned_sequence.fasta
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [clustalo]

requirements:
  DockerRequirement:
    dockerPull: "biocontainers/clustalo:v1.2.4-2-deb_cv1"

# Inputs
inputs:
  clustalo_inputs:
    type: File
    inputBinding:
      prefix: "-i"
      position: 1
  clustalo_format:
    type: string
    default: "fasta"
    inputBinding:
      prefix: "--outfmt"
      position: 2
  clustalo_output_name:
    type: string
    inputBinding:
      prefix: "-o"
      position: 3

outputs:
  clustalo_output:
    type: File
    outputBinding:
      glob: "$(inputs.clustalo_output_name)"

