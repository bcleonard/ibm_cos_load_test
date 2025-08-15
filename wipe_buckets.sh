#!/bin/sh

WORKING_DIR="/usr/local/scripts/"

echo "WIPING DATA in ${MODE} mode."
CRED_FILE="${WORKING_DIR}/${MODE}_credentials.json"
LOAD_FILE="${WORKING_DIR}/${MODE}_load_test.json"
export PYTHONWARNINGS="ignore:Unverified HTTPS request"

# print version of awscli installed
aws --version

# get keys
export AWS_ACCESS_KEY_ID=`jq -r '.access_key' ${CRED_FILE}`
export AWS_SECRET_ACCESS_KEY=`jq -r '.secret_key' ${CRED_FILE}`

# get accesser name
ACC=`jq -r '.host' ${LOAD_FILE}`

# loop through buckets
for BUCKET in `jq -r '.containers[]' ${CRED_FILE}`
do
  echo "REMOVING ALL OBJECTS FROM: ${BUCKET}"
  aws s3 rm s3://${BUCKET} --no-verify-ssl --quiet --recursive --endpoint-url https://${ACC}
  echo "DONE"
done

