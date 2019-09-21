cd "${0%/*}"

./../Ambassador/install-ambassador.sh
sleep 5
./../cert-manager/install-cert-manager.sh
sleep 15
./../Rook/override-apply-cluster.sh
sleep 5
./../Jenkins/install-jenkins.sh
sleep 5
./../Flux/install-flux.sh
