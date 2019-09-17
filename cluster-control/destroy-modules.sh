cd "${0%/*}"

./../Ambassador/destroy-ambassador.sh
sleep 5
./../cert-manager/destroy-cert-manager.sh
sleep 5
./../Rook/destroy-cluster.sh
