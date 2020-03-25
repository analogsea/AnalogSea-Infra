cd "${0%/*}"

helm uninstall flux -n flux

kubectl delete secret -n flux flux-gpg-signing-key

if [[ -f "manifests/flux-git-ssh-key.yaml" ]]; then
  kubectl delete -f manifests/flux-git-ssh-key.yaml
fi
if [[ -f "manifests/sealed-flux-git-ssh-key.yaml" ]]; then
  kubectl delete -f manifests/sealed-flux-git-ssh-key.yaml
fi
