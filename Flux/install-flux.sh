cd "${0%/*}"

kubectl apply -f manifests/flux_namespace.yaml
# export GHUSER="iExalt"
fluxctl install \
--git-user=iExalt \
--git-email=iExalt@users.noreply.github.com \
--git-url=git@github.com:analogsea/AnalogSea-Flux \
--git-path=namespaces,workloads \
--namespace=flux | kubectl apply -f -
