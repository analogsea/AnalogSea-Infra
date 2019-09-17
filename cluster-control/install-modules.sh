cd "${0%/*}"

./../cert-manager/install-cert-manager.sh
sleep 5
./../Ambassador/install-ambassador.sh
sleep 5
./../Rook/override-apply-cluster.sh
