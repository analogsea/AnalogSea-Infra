cd "${0%/*}"
kubectl apply -f ../manifests/common.yaml
kubectl apply -f ../manifests/operator.yaml
kubectl apply -f ../manifests/cluster.yaml
kubectl apply -f ../manifests/toolbox.yaml
kubectl apply -f ../manifests/block_pools.yaml
kubectl apply -f ../manifests/storageclass.yaml
kubectl apply -f ../manifests/dashboard-external-80.yaml
