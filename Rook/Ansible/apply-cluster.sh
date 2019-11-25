#!/bin/bash
cd "${0%/*}"

kubectl apply -f manifests/common.yaml
kubectl apply -f manifests/operator.yaml
kubectl apply -f manifests/cluster-test.yaml

kubectl apply -f manifests/object_store.yaml
kubectl apply -f manifests/object_store_user.yaml
kubectl apply -f manifests/block_pools.yaml
kubectl apply -f manifests/toolbox.yaml
kubectl apply -f manifests/storageclasses.yaml
