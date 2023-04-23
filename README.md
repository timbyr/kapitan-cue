# Description

Attempt to use kapitan to generate Kubernetes style documents from cuelang.

Purpose is to generate stable Kustomize bases that are validated by cuelang as a preprocessor.

This allows for at least two interesting use cases
* The use of [KRM functions](https://github.com/kubernetes-sigs/kustomize/blob/master/cmd/config/docs/api-conventions/functions-spec.md). Examples of functions are available [here](https://github.com/GoogleContainerTools/kpt-functions-catalog)

# FAQ

## Cuelang Generators

Kapitans external generator doesn't load the path. It either requires absolute path or an executable in Kapitan specific directories.

There may be an easier way to solve this but but an executable script `./lib/cue` that use /bin/env to call the cuelang binary was straightfoward to be consistent between environments this is run from.

## Cuelang inventory

Two options

### yaml_cue

Kapitan yaml_cue storage. Modified kapitan that can call cuelang directly so no preprocessing is required

To use
```
pipenv shell
pipenv install
kapitan compile
```

### Preprocessed cue

All cue files are converted to yaml via Make targets

### Which is faster

Timings are comparable for clean runs for example inventory

#### yaml_cue
```
❯ time kapitan compile
Rendered inventory (2.97s)
Compiled my_target (0.30s)
kapitan compile  10.00s user 2.60s system 248% cpu 5.080 total
```

#### Preprocessed cue
```
❯ time bash -c "make cue && kapitan compile && make clean"
cue export inventory/classes/metricsserver/init.cue --outfile inventory/classes/metricsserver/init.yml --out yaml
cue export inventory/classes/metricsserver/kustomize.cue --outfile inventory/classes/metricsserver/kustomize.yml --out yaml
cue export inventory/classes/metricsserver/resources.cue --outfile inventory/classes/metricsserver/resources.yml --out yaml
cue export inventory/classes/metricsserver/version.cue --outfile inventory/classes/metricsserver/version.yml --out yaml
cue export inventory/classes/common.cue --outfile inventory/classes/common.yml --out yaml
cue export inventory/targets/my_target.cue --outfile inventory/targets/my_target.yml --out yaml
Rendered inventory (0.05s)
Compiled my_target (0.38s)
rm -f ./inventory/classes/metricsserver/init.yml ./inventory/classes/metricsserver/kustomize.yml ./inventory/classes/metricsserver/resources.yml ./inventory/classes/metricsserver/version.yml ./inventory/classes/common.yml ./inventory/targets/my_target.yml
bash -c "make cue && kapitan compile && make clean"  9.43s user 2.82s system 220% cpu 5.550 total
``````

# Next Steps

## Use shared cue packages to define the basic Kubernetes/Kustomize types

## Understand if Kubernetes $patch directives can be emitted from cues yaml encoder. Currently don't believe this is the case, so probably requires an extension of the encoder

Kustomize uses this for modifiation of strategic merges. JsonPatches can also be used, but strategic merges can be easier to write. 
