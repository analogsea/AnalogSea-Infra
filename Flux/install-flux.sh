cd "${0%/*}"

kubectl apply -f manifests/flux_namespace.yaml
helm repo add fluxcd https://charts.fluxcd.io

gpg --export-secret-keys --armor | kubectl create secret generic flux-gpg-signing-key -n flux --from-file=flux.asc=/dev/stdin

GPG_KEY_ID=$(gpg --list-secret-keys --with-colons 2> /dev/null | grep '^sec:' | cut --delimiter ':' --fields 5)

export GPG_KEY_ID

cat templates/flux_vars.yaml.template | envsubst > manifests/flux_vars.yaml

helm install flux fluxcd/flux -n flux -f manifests/flux_vars.yaml

kubectl wait --for=condition=available deployment/flux -n flux > /dev/null 2>&1
EXIT_CODE=$?
while [ "$EXIT_CODE" != "0" ]
do
  echo "Waiting for Flux deployment to become available..."
  kubectl wait --for=condition=available deployment/flux -n flux > /dev/null 2>&1
  EXIT_CODE=$?
  sleep 4
done
echo "Flux online, continuing..."

echo "Add this key to the repository's deployment keys and allow write access:"
fluxctl identity --k8s-fwd-ns flux
