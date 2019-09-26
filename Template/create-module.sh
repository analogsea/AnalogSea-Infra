if [[ $# -eq 0 ]] ; then
    echo 'Usage: create-module.sh NAME'
    exit 0
fi

MODULE_NAME=$1
MODULE_NAMESPACE=$2

export MODULE_NAME MODULE_NAMESPACE
mkdir -p $MODULE_NAME

for DIRECTORY in $(find template-manifests -type d); do
  LOCATION=$(echo $DIRECTORY | sed "s/template/$MODULE_NAME/g")
  mkdir -p "$MODULE_NAME/$LOCATION"
done

for FILE in $(find template-manifests -type f); do
  LOCATION=$(echo $FILE | sed "s/template/$MODULE_NAME/g")
  cat $FILE | envsubst > "$MODULE_NAME/$LOCATION";
done
