cd "${0%/*}"
kubectl apply -f kubevirt-cm-override.yaml
kubectl apply -f kubevirt-operator.yaml
kubectl apply -f kubevirt-cr.yaml
