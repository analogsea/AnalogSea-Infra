cd "${0%/*}"

./../KubeFormation/Ansible/skip_prereqs_single_master.sh
scp analogsea.ca:/home/cliaw/.kube/config ~/.kube/config
