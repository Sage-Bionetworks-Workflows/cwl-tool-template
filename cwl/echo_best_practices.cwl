#!/usr/bin/env cwl-runner

class: CommandLineTool
cwlVersion: v1.0

label: Print given message using `echo` and capture output

doc: >
  The `echo` command-line utility is used to print a message,
  which is captured from standard output.

  Visit the Linux manual page for more information:
    https://www.freebsd.org/cgi/man.cgi?query=echo

requirements:
  - class: ShellCommandRequirement

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/cwl-tool-template:0.0.19

baseCommand:
  - echo

inputs:

  extra_args:
    type: string?
    label: Additional command-line (usually optional) arguments
    inputBinding:
      position: 0
      shellQuote: false

  message:
    type: string
    inputBinding:
      position: 1

outputs:

  output_file:
    type: File
    format: edam:format_1964  # Plain text
    outputBinding:
      glob: out.txt

  output_contents:
    type: string
    outputBinding:
      glob: out.txt
      loadContents: true
      outputEval: $(self[0].contents)

stdout: out.txt

$namespaces:
  s: https://schema.org/
  edam: http://edamontology.org/

s:author:
  - class: s:Person
    s:email: tess.thyer@sagebase.org
    s:name: Tess Thyer
  - class: s:Person
    s:identifier: https://orcid.org/0000-0002-4621-1589
    s:email: bruno.grande@sagebase.org
    s:name: Bruno Grande

s:license: https://spdx.org/licenses/Apache-2.0
