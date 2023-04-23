package gen

import (
  "path"
	"tool/cli"
	"tool/file"
	"tool/os"
  "encoding/yaml"
)

_outputKustomization: [
  kustomization,
]

command: gen_yaml: {
  _outputDirectory: os.Getenv & {
    OUTPUT_DIRECTORY: string
  }

  task: mkdir: file.Mkdir & {
    path: _outputDirectory.OUTPUT_DIRECTORY
    createParents: true
  }
  task: writeKustomization: file.Create & {
    filename: path.Join([_outputDirectory.OUTPUT_DIRECTORY, "kustomization.yaml"], path.Unix)
    contents: yaml.MarshalStream(_outputKustomization)
  }
  task: writePatches: file.Create & {
    filename: path.Join([_outputDirectory.OUTPUT_DIRECTORY, "patches.yaml"], path.Unix)
    contents: yaml.MarshalStream(_patches)
  }
	task: print: cli.Print & {
		text: yaml.MarshalStream(_outputKustomization)
	}
}
