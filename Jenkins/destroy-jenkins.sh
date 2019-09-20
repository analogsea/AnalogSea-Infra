cd "${0%/*}"

kubectl delete -f manifests/tls
helm uninstall jenkins -n jenkins
kubectl delete ns jenkins
