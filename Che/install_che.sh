cd "${0%/*}"
kubectl apply -f manifests/che-namespace.yaml
chectl server:start -a helm -i eclipse/che-server:nightly -p k8s -n che
