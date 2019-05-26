#!/usr/bin/env make
# vim: tabstop=8 noexpandtab

# Grab some ENV stuff
TF_VAR_envBuild		?= $(shell $(TF_VAR_envBuild))
TF_VAR_cluster_name	?= $(shell $(TF_VAR_cluster_name))
TF_VAR_minDistSize	?= $(shell $(TF_VAR_minDistSize))

# Start Terraforming
prep:	 ## Prepare for the build
	@scripts/setup/set-kubes-params.sh
	@printf '\n\n%s\n' "SOURCE-IN YOUR ENV VARIABLES; EXAMPLE:"
	@printf '\n%s\n\n' "  source scripts/setup/build.env envBuild"

all:	ops etcd  ## All-in-one

ops:	## Send the etcd Operator out to the cluster
	kubectl config use-context $(TF_VAR_cluster_name)
	helm install stable/etcd-operator --name etcd-ops-$(TF_VAR_envBuild)
	
etcd:	## Send etcd out to the cluster
	helm install bitnami/etcd --name configs-$(TF_VAR_envBuild) \
		--values=addons/etcd-values.yaml 

# ------------------------ 'make all' ends here ------------------------------#

clean:	## exfil etc to retest
	helm delete --purge configs-stage
	helm delete --purge etcd-ops-stage

#-----------------------------------------------------------------------------#
#------------------------   MANAGERIAL OVERHEAD   ----------------------------#
#-----------------------------------------------------------------------------#
print-%  : ## Print any variable from the Makefile (e.g. make print-VARIABLE);
	@echo $* = $($*)

.PHONY: help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-16s\033[0m %s\n", $$1, $$2}'

.DEFAULT_GOAL := help

