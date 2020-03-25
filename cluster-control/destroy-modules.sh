cd "${0%/*}"

echo "Destroying sealed-secrets"
./../sealed-secrets/destroy-sealed-secrets.sh
sleep 2
echo "Destroying Flux"
./../Flux/destroy-flux.sh
sleep 2
echo "Destroying Jenkins"
./../Jenkins/destroy-jenkins.sh
sleep 2
echo "Destroying Rook"
./../Rook/destroy-cluster.sh
sleep 2
echo "Destroying cert-manager"
./../cert-manager/destroy-cert-manager.sh
sleep 2
echo "Destroying Ambassador"
./../Ambassador/destroy-ambassador.sh
