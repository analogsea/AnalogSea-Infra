cd "${0%/*}"
kubectl apply -f manifests/jenkins_namespace.yaml
#kubectl apply -f manifests/jenkins-mapping.yaml
# kubectl apply -f manifests/tls
helm install jenkins stable/jenkins -n jenkins -f manifests/jenkins_vars.yaml
