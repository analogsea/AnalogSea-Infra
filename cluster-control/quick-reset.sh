cd "${0%/*}"

./../Jenkins/destroy-jenkins.sh
sleep 5
./../Rook/destroy-cluster.sh
sleep 5
./../KubeFormation/Ansible/reset.sh
