package gen

kustomization: {

#source: != "" @tag(source)
#version: != "" @tag(version)

apiVersion: "kustomize.config.k8s.io/v1beta1"
kind:       "Kustomization"

resources: [...string] & [
  #source + "?ref=" + #version
]

patches: [...] & [
  {
    path: "patches.yaml"
  },
]

generators: []

transformers: []

validators: []

}
