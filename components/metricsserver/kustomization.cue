package gen

kustomization: {

#source: string @tag(source)
#version: string @tag(version)

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
