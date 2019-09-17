cd "${0%/*}"

kubectl delete -f manifests/prod/cert-manager/prod-service.yaml
helm uninstall cert-manager -n ambassador
kubectl delete -f manifests/crds.yaml
# kubectl delete -f manifests/cert-manager-namespace.yaml
