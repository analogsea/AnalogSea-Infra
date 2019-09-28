cd "${0%/*}"

kubectl apply -f manifests/sealed-secrets-namespace.yaml
kubectl apply -f manifests/kubeseal.yaml
