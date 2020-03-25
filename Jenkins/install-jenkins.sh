cd "${0%/*}"
kubectl apply -f manifests/jenkins_namespace.yaml
kubectl apply -f manifests/tls
helm install jenkins stable/jenkins -n jenkins -f manifests/jenkins_vars.yaml --version v1.9.16

kubectl wait --for=condition=available deployment/jenkins -n jenkins > /dev/null 2>&1
EXIT_CODE=$?
while [ "$EXIT_CODE" != "0" ]
do
  echo "Waiting for Jenkins deployment to become available..."
  kubectl wait --for=condition=available deployment/jenkins -n jenkins > /dev/null 2>&1
  EXIT_CODE=$?
  sleep 4
done
echo "Jenkins online, continuing..."

./get-password.sh
