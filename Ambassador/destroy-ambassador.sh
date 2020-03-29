cd "${0%/*}"
# helm uninstall ambassador-http -n ambassador
helm uninstall ambassador -n ambassador
# kubectl delete -f manifests/ambassador-namespace.yaml
