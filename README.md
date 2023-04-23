# Description

Attempt to use kapitan to generate Kubernetes style documents from cuelang.

Purpose is to generate stable Kustomize bases that are validated by cuelang as a preprocessor.

This allows for at least two interesting use cases
* The use of [KRM functions](https://github.com/kubernetes-sigs/kustomize/blob/master/cmd/config/docs/api-conventions/functions-spec.md). Examples of functions are available [here](https://github.com/GoogleContainerTools/kpt-functions-catalog)

# FAQ

Kapitans external generator doesn't load the path. It either requires absolute path or an executable in Kapitan specific directories.

There may be an easier way to solve this but but an executable script `./lib/cue` that use /bin/env to call the cuelang binary was straightfoward to be consistent between environments this is run from.

# Next Steps

## Use shared cue packages to define the basic Kubernetes/Kustomize types

## Understand if Kubernetes $patch directives can be emitted from cues yaml encoder. Currently don't believe this is the case, so probably requires an extension of the encoder

Kustomize uses this for modifiation of strategic merges. JsonPatches can also be used, but strategic merges can be easier to write. 

## Write the reclass definitions in cuelang so reclass can be modeled and validated outside of parameter expansion.
