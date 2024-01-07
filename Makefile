SHELL := /usr/bin/env bash

help:
	@echo "Arguments:"
	@printf "\033[34m%-30s\033[0m %s\n" container "The container name (make command container=<name>)"
	@printf "\033[34m%-30s\033[0m %s\n" registry "The registry name (make command registry=<address>)"
	@echo
	@echo "Commands:"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[34m%-30s\033[0m %s\n", $$1, $$2}'

build: DEPENDENCIES CONTAINER ## Build single OCI container
	podman build $${container}

tag: DEPENDENCIES CONTAINER REGISTRY ## Build, tag single OCI container
	podman build $${container} --tag=$${registry}/$${container}:$$(cat $${container}/VERSION)

push: DEPENDENCIES CONTAINER REGISTRY ## Build, tag, push single OCI container
	podman build $${container} --tag=$${registry}/$${container}:$$(cat $${container}/VERSION)
	podman push $${registry}/$${container}:$$(cat $${container}/VERSION)

build-all: DEPENDENCIES ## Build all OCI containers
	@for container in $$(find * -maxdepth 1 -type d); do podman build $${container}; done

tag-all: DEPENDENCIES REGISTRY ## Build, tag all OCI containers
	@for container in $$(find * -maxdepth 1 -type d); do \
		podman build $${container} --tag=$${registry}/$${container}:$$(cat $${container}/VERSION); \
	done

push-all: DEPENDENCIES REGISTRY ## Build, tag, push all OCI containers
	@for container in $$(find * -maxdepth 1 -type d); do \
		podman build $${container} --tag=$${registry}/$${container}:$$(cat $${container}/VERSION); \
		podman push $${registry}/$${container}:$$(cat $${container}/VERSION); \
	done

DEPENDENCIES: ;
	@if [ ! -e "$$(which podman)" ]; then echo "* Please install package 'podman'."; echo; exit 1; fi

CONTAINER: ;
	@if [ -z "$${container}" ]; then echo "* Please define the container argument:"; echo "  make command container=<name>"; echo; exit 1; fi

REGISTRY: ;
	@if [ -z "$${registry}" ]; then echo "* Please define the registry argument:"; echo "  make command registry=<address>"; echo; exit 1; fi
