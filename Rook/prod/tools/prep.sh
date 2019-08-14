cd "${0%/*}"
kubectl apply -f ../manifests/dashboard-external-32350.yaml
bash get_password.sh
bash set_pool.sh
