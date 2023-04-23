cue_files := $(shell find ./inventory -name "*.cue")
yaml_files := $(patsubst %.cue,%.yml,$(cue_files))

all: clean cue compile

.PHONY: cue
cue: $(yaml_files)

%.yml: %.cue
	cue export $< --outfile $@ --out yaml

.PHONY: clean
clean:
	$(RM) $(yaml_files)

.PHONY: compile
compile:
	kapitan compile
