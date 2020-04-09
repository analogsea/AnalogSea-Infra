cd "${0%/*}"
kubectl apply -f manifests/ambassador-namespace.yaml

# helm repo add datawire https://www.getambassador.io
# helm repo update

helm install ambassador datawire/ambassador -n ambassador -f manifests/ambassador-vars.yaml --version v6.2.5

kubectl apply -f manifests/ambassador-module.yaml
