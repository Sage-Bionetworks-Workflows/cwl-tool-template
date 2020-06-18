arguments:
- $(inputs.message)
baseCommand:
- echo
- -n
class: CommandLineTool
cwlVersion: v1.0
hints:
  DockerRequirement:
    dockerPull: sagebionetworks/dockstore-tool-template:0.0.5-c25a292
inputs:
  message:
    type: string
outputs:
  out:
    outputBinding:
      glob: out.txt
      loadContents: true
      outputEval: $(self[0].contents)
    type: string
stdout: out.txt
