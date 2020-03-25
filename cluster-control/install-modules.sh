cd "${0%/*}"

./../Ambassador/install-ambassador.sh
sleep 2
./../cert-manager/install-cert-manager.sh
sleep 2
./../Rook/apply-cluster.sh
sleep 2
./../Jenkins/install-jenkins.sh
sleep 2
./../sealed-secrets/install-sealed-secrets.sh
sleep 2
./../Flux/install-flux.sh
