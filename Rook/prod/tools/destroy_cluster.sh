cd "${0%/*}"
kubectl -n rook-ceph delete cephcluster rook-ceph
kubectl delete -f ../manifests/operator.yaml
kubectl delete -f ../manifests/common.yaml

source $(which virtualenvwrapper.sh)
workon automation
sleep 10
ansible-playbook -i ../Ansible/inventory.yaml ../Ansible/cleanup.yaml
