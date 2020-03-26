cd "${0%/*}"

#kubectl delete -f manifests/kubeseal.yaml
helm uninstall sealed-secrets-controller -n kube-system
