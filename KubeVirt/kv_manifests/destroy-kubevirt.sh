cd "${0%/*}"
kubectl delete -f kubevirt-cr.yaml
kubectl delete -f kubevirt-operator.yaml &
echo "Sleeping before killing ns"
sleep 30
./kill_ns.sh kubevirt
exit 0
