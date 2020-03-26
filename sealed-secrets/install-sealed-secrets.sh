cd "${0%/*}"

#kubectl apply -f manifests/sealed-secrets-namespace.yaml
# kubectl apply -f manifests/kubeseal.yaml
helm install sealed-secrets-controller stable/sealed-secrets -n kube-system -f manifests/sealed-secrets-vars.yaml
