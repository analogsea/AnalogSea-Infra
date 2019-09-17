cd "${0%/*}"

kubectl delete -f manifests/tls/jenkins-certificate.yaml
kubectl delete -f manifests/tls/jenkins-certificate-mapping.yaml
kubectl delete -f manifests/tls/jenkins-tlscontext.yaml
helm uninstall jenkins -n jenkins
kubectl delete ns jenkins
