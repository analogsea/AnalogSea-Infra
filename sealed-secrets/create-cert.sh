cd "${0%/*}"

if (( $# == 0 )); then
  echo "Using default ssh private key ~/.ssh/id_rsa to create cert"
  openssl req -x509 -key $HOME/.ssh/id_rsa -days 3650 -subj "/C=GB/ST=London/L=London/O=SS/OU=SS/CN=SS" |  kubectl create secret tls sealed-secrets-key -n kube-system --key=$HOME/.ssh/id_rsa --cert=/dev/stdin

elif (( $# == 1 )); then
  echo "Using specified ssh private key"
  openssl req -x509 -key $1 -days 3650 -subj "/C=GB/ST=London/L=London/O=SS/OU=SS/CN=SS" |  kubectl create secret tls sealed-secrets-key -n kube-system --key=$1 --cert=/dev/stdin
fi
