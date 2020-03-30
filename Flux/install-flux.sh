cd "${0%/*}"

kubectl apply -f manifests/flux_namespace.yaml
helm repo add fluxcd https://charts.fluxcd.io

if [[ -f "manifests/flux-git-ssh-key.yaml" ]]; then
  kubectl apply -f manifests/flux-git-ssh-key.yaml
  sleep 2
elif [[ -f "manifests/sealed-flux-git-ssh-key.yaml" ]]; then
  kubectl apply -f manifests/sealed-flux-git-ssh-key.yaml
  sleep 2
fi

helm install flux fluxcd/flux -n flux -f manifests/flux_vars.yaml

kubectl wait --for=condition=available deployment/flux -n flux > /dev/null 2>&1
EXIT_CODE=$?
while [ "$EXIT_CODE" != "0" ]; do
  echo "Waiting for Flux deployment to become available..."
  kubectl wait --for=condition=available deployment/flux -n flux > /dev/null 2>&1
  EXIT_CODE=$?
  sleep 4
done
echo "Flux online, continuing..."

echo "Add this key to the repository's deployment keys and allow write access:"
fluxctl identity --k8s-fwd-ns flux
