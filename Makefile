.PHONY: help all run check install
.DEFAULT_GOAL := all

REQUIRED_BINS := ansible-playbook pip ansible-galaxy ansible-lint
$(foreach bin,$(REQUIRED_BINS),\
    $(if $(shell command -v $(bin) 2> /dev/null),,$(error Please install `$(bin)`)))

help: ## This help.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

all: run
run: ## Launch playbook - create all
	ansible-playbook -i inventory.yml site.yml

check: ## Launch playbook - dry run
	ansible-lint
	ansible-playbook -i inventory.yml site.yml --check

install:
	ansible-galaxy install -r requirements.yml
