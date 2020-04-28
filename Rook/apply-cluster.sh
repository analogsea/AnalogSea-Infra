#!/bin/bash
cd "${0%/*}"

# kubectl apply -f manifests/rook-ceph-namespace.yaml
# kubectl apply -f manifests/config-override.yaml

kubectl apply -f manifests/common.yaml
kubectl apply -f manifests/operator.yaml
kubectl apply -f manifests/cluster-test.yaml

kubectl apply -f manifests/tls/ceph-certificate-mapping.yaml
kubectl apply -f manifests/tls/ceph-certificate.yaml
kubectl apply -f manifests/tls/ceph-tlscontext.yaml
kubectl apply -f manifests/tls/ceph-mapping.yaml

kubectl apply -f manifests/tls/rgw-certificate-mapping.yaml
kubectl apply -f manifests/tls/rgw-certificate.yaml
kubectl apply -f manifests/tls/rgw-tlscontext.yaml
kubectl apply -f manifests/tls/rgw-mapping.yaml


kubectl wait --for=condition=available deployment/rook-ceph-osd-0 -n rook-ceph > /dev/null 2>&1
EXIT_CODE=$?
while [ "$EXIT_CODE" != "0" ]
do
  echo "Waiting for Rook deployment to become available..."
  kubectl wait --for=condition=available deployment/rook-ceph-osd-0 -n rook-ceph > /dev/null 2>&1
  EXIT_CODE=$?
  sleep 4
done
echo "First OSD created, continuing..."

kubectl apply -f manifests/object-store.yaml
kubectl apply -f manifests/cephfs-pools.yaml
kubectl apply -f manifests/block-pools.yaml
kubectl apply -f manifests/toolbox.yaml
kubectl apply -f manifests/storageclasses.yaml
kubectl apply -f manifests/snapshotclasses.yaml

kubectl wait --for=condition=available deployment/rook-ceph-rgw-object-store-a -n rook-ceph > /dev/null 2>&1
EXIT_CODE=$?
while [ "$EXIT_CODE" != "0" ]
do
  echo "Waiting for rgw deployment to become available..."
  kubectl wait --for=condition=available deployment/rook-ceph-rgw-object-store-a -n rook-ceph > /dev/null 2>&1
  EXIT_CODE=$?
  sleep 4
done
echo "rgw created, continuing..."

kubectl apply -f manifests/object-store-user.yaml
./set-pool.sh
