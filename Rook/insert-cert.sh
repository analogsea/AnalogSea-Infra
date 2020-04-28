cd "${0%/*}"

./tools.sh echo $(kubectl get secret restful-cert -o jsonpath="{.data['tls\.crt']}" -n ambassador) > /root/restful.pem
