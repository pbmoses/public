#!/bin/bash
##provided to me from Christian Hernandez
[[ ${#*} -eq 0 ]] && echo "Please provide something to export" && exit 2

if ! which yq >/dev/null 2>&1 ; then
	echo "Please install yq"
	exit 3
fi
#
kubectl get $* -o yaml \
| yq eval 'del(.metadata.resourceVersion)' - \
| yq eval 'del(.metadata.uid)' - \
| yq eval 'del(.metadata.annotations)' - \
| yq eval 'del(.metadata.creationTimestamp)' - \
| yq eval 'del(.metadata.selfLink)' - \
| yq eval 'del(.metadata.managedFields)' - \
| yq eval 'del(.metadata.finalizers)' - \
| yq eval 'del(.metadata.ownerReferences)' - \
| yq eval 'del(.metadata.generation)' - \
| yq eval 'del(.status)' -
##
##
