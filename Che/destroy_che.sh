cd "${0%/*}"
kubectl apply -f manifests/
chectl server:delete
