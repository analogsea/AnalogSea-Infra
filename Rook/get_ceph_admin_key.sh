kubectl -n rook-ceph get secret rook-ceph-admin-keyring -o jsonpath="{['data']['keyring']}" | base64 --decode && echo
