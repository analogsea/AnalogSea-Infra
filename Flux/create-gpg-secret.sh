cd "${0%/*}"

if [ "$#" -ne 1 ]; then
  echo -n "Usage: create-gpg-secret.sh "
  tput smul
  tput bold
  echo "email"
  tput sgr0
  exit 1

else
  kubectl apply -f manifests/flux_namespace.yaml
  gpg --export-secret-keys --armor $1 | kubectl create secret generic flux-gpg-signing-key -n flux --from-file=flux.asc=/dev/stdin
fi
