cwlVersion: v1.0
class: CommandLineTool
baseCommand:
- echo
- -n
stdout: out.txt

hints:
  DockerRequirement:
    dockerPull: sagebionetworks/dockstore-tool-template:0.0.7

arguments:
- $(inputs.message)

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
