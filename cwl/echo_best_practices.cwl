$namespaces:
  edam: http://edamontology.org/
  s: https://schema.org/
s:author:
- class: s:Person
  s:email: tess.thyer@sagebase.org
  s:name: Tess Thyer
- class: s:Person
  s:email: bruno.grande@sagebase.org
  s:identifier: https://orcid.org/0000-0002-4621-1589
  s:name: Bruno Grande
s:license: https://spdx.org/licenses/Apache-2.0

class: CommandLineTool
cwlVersion: v1.0
baseCommand:
- echo
stdout: out.txt

label: Print given message using `echo` and capture output
doc: "The `echo` command-line utility is used to print a message, which is captured\
  \ from standard output.\nVisit the Linux manual page for more information:\n  https://www.freebsd.org/cgi/man.cgi?query=echo\n"

requirements:
- class: ShellCommandRequirement
hints:
  DockerRequirement:
    dockerPull: sagebionetworks/dockstore-tool-template:0.0.11
inputs:
  extra_args:
    type: string?
    inputBinding:
      position: 0
      shellQuote: false
    label: Additional command-line (usually optional) arguments

  message:
    type: string
    inputBinding:
      position: 1

outputs:
  output_contents:
    type: string
    outputBinding:
      glob: out.txt
      loadContents: true
      outputEval: $(self[0].contents)
  output_file:
    type: File
    format: edam:format_1964
    outputBinding:
      glob: out.txt
