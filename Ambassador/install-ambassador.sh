cd "${0%/*}"
kubectl apply -f manifests/ambassador-namespace.yaml
helm install ambassador-http stable/ambassador -n ambassador -f manifests/ambassador-http-vars.yaml --version v5.3.0
helm install ambassador-https stable/ambassador -n ambassador -f manifests/ambassador-https-vars.yaml --version v5.3.0
