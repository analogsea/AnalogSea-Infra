cd "${0%/*}"

./../Jenkins/destroy-jenkins.sh
sleep 2
./../Rook/destroy-cluster.sh
sleep 2
./../KubeFormation/Ansible/reset.sh
