cd "${0%/*}"

AWS_ACCESS_KEY_ID=$(kubectl -n rook-ceph get secret rook-ceph-object-user-ceph-object-spinnaker -o yaml | grep AccessKey | awk '{print $2}' | base64 --decode)
AWS_SECRET_ACCESS_KEY=$(kubectl -n rook-ceph get secret rook-ceph-object-user-ceph-object-spinnaker -o yaml | grep SecretKey | awk '{print $2}' | base64 --decode)

kubectl apply -f manifests/spinnaker-namespace.yaml
# helm install spinnaker stable/spinnaker -n spinnaker -f manifests/spinnaker-vars.yaml
hal config provider kubernetes enable

CONTEXT=$(kubectl config current-context)
ACCOUNT="spinnaker-account"
SPINNAKER_NAMESPACE="spinnaker"
LONGEST_SERVICE_STARTUP_TIME=20
AWS_ENDPOINT="https://s3.analogsea.ca"
# Region doesn't matter with RGW
REGION="us-west-1"
VERSION="1.16.1"

hal config provider kubernetes account add $ACCOUNT \
    --provider-version v2 \
    --context $CONTEXT

hal config features edit --artifacts true

hal config deploy edit --type distributed --account-name $ACCOUNT

hal config deploy edit --liveness-probe-enabled true --liveness-probe-initial-delay-seconds $LONGEST_SERVICE_STARTUP_TIME

hal config storage s3 edit \
    --endpoint $AWS_ENDPOINT \
    --access-key-id $AWS_ACCESS_KEY_ID \
    --secret-access-key $AWS_SECRET_ACCESS_KEY \
    # Only need region flag when the bucket doesn't exist yet

    # --region $REGION

hal config storage edit --type s3

hal config version edit --version $VERSION

hal config deploy edit --location $SPINNAKER_NAMESPACE

# hal deploy apply

# hal backup create
