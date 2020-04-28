cd "${0%/*}"

helm uninstall sealed-secrets-controller -n kube-system
