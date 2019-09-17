cd "${0%/*}"
kubectl apply -f cdi-operator.yaml
kubectl apply -f cdi-operator-cr.yaml
