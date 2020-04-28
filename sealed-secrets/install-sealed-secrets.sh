cd "${0%/*}"

helm repo update
helm install sealed-secrets-controller stable/sealed-secrets -n kube-system -f manifests/sealed-secrets-vars.yaml --version 1.8.0
