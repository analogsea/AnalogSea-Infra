cd "${0%/*}"

kubectl delete -f manifests/dev/dev-service.yaml
kubectl delete -f manifests/prod/prod-service.yaml
# kubectl delete -f manifests/dev/dev-
helm uninstall cert-manager -n ambassador
kubectl delete -f manifests/00-crds.yaml
