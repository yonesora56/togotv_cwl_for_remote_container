#!/usr/bin/env cwl-runner
# Generated from: fasttree -nt clustalo_result.fasta > fasttree_result.nwk
class: CommandLineTool
cwlVersion: v1.0
baseCommand: fasttree
arguments:
  - -nt
  - $(inputs.nt)
inputs:
  - id: nt
    type: File
    default:
      class: File
      location: clustalo_result.fasta
outputs:
  - id: all-for-debugging
    type:
      type: array
      items: [File, Directory]
    outputBinding:
      glob: "*"
  - id: out
    type: stdout
stdout: fasttree_result.nwk
hints:
  - class: DockerRequirement
    dockerPull: biocontainers/fasttree:v2.1.10-2-deb_cv1
