cd "${0%/*}"
kubectl apply -f manifests/dashboard_external_32350.yaml
./get_password.sh
./set_pool.sh
