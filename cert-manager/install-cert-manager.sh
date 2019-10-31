cd "${0%/*}"
# Install the CustomResourceDefinition resources separately
kubectl apply --validate=false -f manifests/00-crds.yaml

# Create the namespace for cert-manager
# kubectl apply -f manifests/cert-manager-namespace.yaml

# Label the cert-manager namespace to disable resource validation
# kubectl label namespace ambassador --overwrite certmanager.k8s.io/disable-validation=true

# Add the Jetstack Helm repository
helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
helm repo update

# Install the cert-manager Helm chart
helm install cert-manager jetstack/cert-manager -n ambassador --version v0.11.0 -f manifests/cert-manager_vars.yaml

echo "Waiting for cert-manager to come up..."
sleep 30

# Install issuer
kubectl apply -f manifests/prod/cert-manager/prod-issuer.yaml

# Install service
kubectl apply -f manifests/prod/cert-manager/prod-service.yaml
