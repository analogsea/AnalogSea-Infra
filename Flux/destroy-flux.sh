cd "${0%/*}"

helm uninstall flux -n flux
kubectl delete ns flux
