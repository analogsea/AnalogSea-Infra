cd "${0%/*}"
kubectl delete -f manifests/tls/ceph-certificate.yaml
kubectl delete -f manifests/tls/ceph-certificate-mapping.yaml
kubectl delete -f manifests/tls/ceph-tlscontext.yaml
kubectl delete -f manifests/secret.yaml
kubectl delete -f manifests/csi_storageclass.yaml
kubectl -n rook-ceph delete cephcluster rook-ceph
kubectl delete -f manifests/operator_with_csi.yaml
kubectl delete -f manifests/common.yaml

VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3 source $(which virtualenvwrapper.sh)
workon automation
echo "Pausing 10s to allow resources to delete..."
sleep 10
ansible-playbook -i Ansible/inventory.yaml Ansible/cleanup.yaml
