cd "${0%/*}"
# Install the CustomResourceDefinition resources separately
kubectl apply --validate=false -f manifests/00-crds.yaml

# Add the Jetstack Helm repository
# helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
# helm repo update

# Install the cert-manager Helm chart
helm install cert-manager jetstack/cert-manager -n ambassador --version v0.12.0

echo "Waiting for cert-manager to come up..."
sleep 25

# Install dev issuer and service
kubectl apply -f manifests/dev/dev-issuer.yaml
kubectl apply -f manifests/dev/dev-service.yaml

# Install prod issuer and service
kubectl apply -f manifests/prod/prod-issuer.yaml
kubectl apply -f manifests/prod/prod-service.yaml
