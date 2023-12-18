SHELL := bash

build:
	vagrant up
.PHONY: build

rebuild:
	vagrant reload --provision
.PHONY: rebuild

destroy:
	vagrant destroy --force
.PHONY: destroy

package:
	vagrant package workstation
	# TODO - can optionally package, store in s3, refetch/rehydrate for reuse
.PHONY: package
