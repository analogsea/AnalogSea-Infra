cd "${0%/*}"

kubectl apply -f manifests/$MODULE_NAME-namespace.yaml
