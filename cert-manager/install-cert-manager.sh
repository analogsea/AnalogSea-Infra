cd "${0%/*}"
# Install the CustomResourceDefinition resources separately
kubectl apply --validate=false -f manifests/00-crds.yaml

# Add the Jetstack Helm repository
# helm repo add jetstack https://charts.jetstack.io

# Update your local Helm chart repository cache
# helm repo update

# Install the cert-manager Helm chart
helm install cert-manager jetstack/cert-manager -n ambassador --version v0.14.0


kubectl wait --for=condition=available deployment/cert-manager-webhook -n ambassador > /dev/null 2>&1
EXIT_CODE=$?
while [ "$EXIT_CODE" != "0" ]
do
  echo "Waiting for cert-manager-webhook deployment to become available..."
  kubectl wait --for=condition=available deployment/cert-manager-webhook -n ambassador > /dev/null 2>&1
  EXIT_CODE=$?
  sleep 4
done
echo "cert-manager-webhook available, continuing..."

# Install dev issuer and service
kubectl apply -f manifests/dev/dev-issuer.yaml > /dev/null 2>&1
EXIT_CODE=$?
while [ "$EXIT_CODE" != "0" ]
do
  echo "Trying to apply cert-manager dev issuer..."
  kubectl apply -f manifests/dev/dev-issuer.yaml > /dev/null 2>&1
  EXIT_CODE=$?
  sleep 4
done
echo "cert-manager dev issuer available, continuing..."

kubectl apply -f manifests/dev/dev-service.yaml


# Install prod issuer and service
kubectl apply -f manifests/prod/prod-issuer.yaml > /dev/null 2>&1
EXIT_CODE=$?
while [ "$EXIT_CODE" != "0" ]
do
  echo "Trying to apply cert-manager prod issuer..."
  kubectl apply -f manifests/prod/prod-issuer.yaml > /dev/null 2>&1
  EXIT_CODE=$?
  sleep 4
done
echo "cert-manager prod issuer available, continuing..."

kubectl apply -f manifests/prod/prod-service.yaml
