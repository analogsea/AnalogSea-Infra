cd "${0%/*}"

./../cert-manager/destroy-cert-manager.sh
sleep 5
./../Ambassador/destroy-ambassador.sh
sleep 5
./../Rook/destroy-cluster.sh
