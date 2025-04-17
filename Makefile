SHELL := bash

# Targets
.PHONY: help
help: ## Show this help message
	@echo "Workstation Make Targets"
	@echo "Usage: make [target]"
	@echo "Common cases to start quickly will be: \"make build\" and \"vagrant ssh -- -X\""
	@echo ""
	@echo "Targets:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "  %-30s %s\n", $$1, $$2}'

build: ## Builds and starts vagrant workstation. Takes approx. 30 minutes.
	vagrant up
.PHONY: build

rebuild:  ## Rebuilds the image
	vagrant reload --provision
.PHONY: rebuild

destroy: ## Destroys the workstation vagrant box.
	vagrant destroy --force
.PHONY: destroy

package: ## Packages for import.
	vagrant package workstation --output workstation.box
.PHONY: package
