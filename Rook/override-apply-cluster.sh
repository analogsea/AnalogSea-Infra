cd "${0%/*}"
kubectl apply -f manifests/ceph_conf_override.yaml
./apply-cluster.sh
