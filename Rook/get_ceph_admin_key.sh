#kubectl -n rook-ceph exec -it $(kubectl -n rook-ceph get pod -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') cat /etc/ceph/keyring 
kubectl -n rook-ceph get secret rook-ceph-admin-keyring -o jsonpath="{['data']['keyring']}" | base64 --decode && echo
