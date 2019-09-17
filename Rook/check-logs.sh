cd "${0%/*}"

kubectl logs -f job/dbench
