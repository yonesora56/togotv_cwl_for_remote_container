#!/usr/bin/env cwl-runner
# Generated from: docker run --rm -it -v /workspaces/togotv_shooting/data:/workspaces/togotv_shooting/data -w /workspaces/togotv_shooting/data biocontainers/fasttree:v2.1.10-2-deb_cv1 FastTree -out MSTN_tree.newick /workspaces/togotv_shooting/data/MSTN_aligned_sequence.fasta
class: CommandLineTool
cwlVersion: v1.0
baseCommand: [fasttree]

requirements:
  DockerRequirement:
    dockerPull: "biocontainers/fasttree:v2.1.10-2-deb_cv1"

#Inputs
inputs:
  fasttree_output_file_name:
    type: string
    inputBinding:
      prefix: "-out"
      position: 1
  fasttree_input_file:
    type: File
    inputBinding:
      position: 2
# Outputs
outputs:
  fasttree_output_file:
    type: File
    outputBinding:
      glob: "$(inputs.fasttree_output_file_name)"
