cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- echo
- -n
stdout: out.txt

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/cwl-tool-template:0.0.17
inputs:
  message:
    type: string

outputs:
  out:
    type: string
    outputBinding:
      glob: out.txt
      loadContents: true
      outputEval: $(self[0].contents)
