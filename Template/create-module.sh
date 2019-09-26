if [[ $# -eq 0 ]] ; then
    echo 'Usage: create-module.sh NAME'
    exit 0
fi

MODULE_NAME=$1

if [[ $# -eq 2 ]] ; then
  MODULE_NAMESPACE=$2
else
  MODULE_NAMESPACE=$1
fi

echo $MODULE_NAMESPACE

export MODULE_NAME MODULE_NAMESPACE
mkdir -p $MODULE_NAME

cd templates
for DIRECTORY in $(find . -type d); do
  LOCATION=$(echo $DIRECTORY | sed "s/template/$MODULE_NAME/g")
  mkdir -p "../$MODULE_NAME/$LOCATION"
done

for FILE in $(find . -type f); do
  echo $FILE
  LOCATION=$(echo $FILE | sed "s/template/$MODULE_NAME/g")
  cat $FILE | envsubst > "../$MODULE_NAME/$LOCATION";
done
