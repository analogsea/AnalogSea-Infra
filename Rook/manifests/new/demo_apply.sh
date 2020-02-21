#!/bin/bash
cd "${0%/*}"

kubectl apply -f common.yaml -f operator.yaml -f cluster.yaml -f storageclass.yaml

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
#

kubectl apply -f filesystem-test.yaml
