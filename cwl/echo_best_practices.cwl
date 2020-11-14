$namespaces:
  edam: http://edamontology.org/
  s: https://schema.org/
baseCommand:
- echo
class: CommandLineTool
cwlVersion: v1.0
doc: "The `echo` command-line utility is used to print a message, which is captured\
  \ from standard output.\nVisit the Linux manual page for more information:\n  https://www.freebsd.org/cgi/man.cgi?query=echo\n"
hints:
  DockerRequirement:
    dockerPull: sagebionetworks/dockstore-tool-template:0.0.6
inputs:
  extra_args:
    inputBinding:
      position: 0
      shellQuote: false
    label: Additional command-line (usually optional) arguments
    type: string?
  message:
    inputBinding:
      position: 1
    type: string
label: Print given message using `echo` and capture output
outputs:
  output_contents:
    outputBinding:
      glob: out.txt
      loadContents: true
      outputEval: $(self[0].contents)
    type: string
  output_file:
    format: edam:format_1964
    outputBinding:
      glob: out.txt
    type: File
requirements:
- class: ShellCommandRequirement
s:author:
- class: s:Person
  s:email: tess.thyer@sagebase.org
  s:name: Tess Thyer
- class: s:Person
  s:email: bruno.grande@sagebase.org
  s:identifier: https://orcid.org/0000-0002-4621-1589
  s:name: Bruno Grande
s:license: https://spdx.org/licenses/Apache-2.0
stdout: out.txt
