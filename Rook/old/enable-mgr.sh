cd "${0%/*}"
./tools.sh ceph restful create-self-signed-cert
sleep 2
./tools.sh ceph restful create-key analogsea > secrets/analogsea_token.txt
