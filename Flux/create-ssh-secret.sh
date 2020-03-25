cd "${0%/*}"

if [ "$#" -ne 1 ]; then
  echo "Using default path ~/.ssh/id_rsa"
  kubectl apply -f manifests/flux_namespace.yaml
  cat ~/.ssh/id_rsa | kubectl create secret generic flux-git-ssh-key --from-file=identity=/dev/stdin --dry-run -n flux -o yaml > manifests/flux-git-ssh-key.yaml

else
  kubectl apply -f manifests/flux_namespace.yaml
  cat $1 | kubectl create secret generic flux-git-ssh-key --from-file=identity=/dev/stdin --dry-run -n flux -o yaml > manifests/flux-git-ssh-key.yaml
fi
