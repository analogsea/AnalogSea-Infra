cd "${0%/*}"
AWS_ACCESS_KEY_ID=$(kubectl -n rook-ceph get secret rook-ceph-object-user-ceph-object-spinnaker -o yaml | grep AccessKey | awk '{print $2}' | base64 --decode)
AWS_SECRET_ACCESS_KEY=$(kubectl -n rook-ceph get secret rook-ceph-object-user-ceph-object-spinnaker -o yaml | grep SecretKey | awk '{print $2}' | base64 --decode)

s3cmd mb --no-check-certificate --access_key=$AWS_ACCESS_KEY_ID --secret_key=$AWS_SECRET_ACCESS_KEY --host=https://s3.analogsea.ca --host-bucket= s3://spinnaker
