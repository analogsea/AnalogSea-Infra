cd "${0%/*}"
kubectl apply -f manifests/dashboard_external_32350.yaml
bash get_password.sh
bash set_pool.sh
