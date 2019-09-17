cd "${0%/*}"

./../Ambassador/install-ambassador.sh
sleep 5
./../cert-manager/install-cert-manager.sh
sleep 5
./../Rook/override-apply-cluster.sh
