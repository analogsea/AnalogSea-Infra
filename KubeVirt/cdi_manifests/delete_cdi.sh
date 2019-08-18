cd "${0%/*}"
kubectl delete -f cdi-operator.yaml
kubectl delete -f cdi-operator-cr.yaml
