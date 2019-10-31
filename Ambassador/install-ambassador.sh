cd "${0%/*}"
kubectl apply -f manifests/ambassador-namespace.yaml
helm install ambassador-http stable/ambassador -n ambassador -f manifests/ambassador-http-vars.yaml --version v4.4.4
helm install ambassador-https stable/ambassador -n ambassador -f manifests/ambassador-https-vars.yaml --version v4.4.4
