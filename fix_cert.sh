#!/bin/sh

WORKING_DIR="/usr/local/scripts"
CERT_DIR="/usr/local/share/ca-certificates"
CERT_NAME="ibm_cos_internal_ca"

echo "CREATING CERT DIR:"
mkdir -p ${CERT_DIR}/${CERT_NAME}

echo "COPY CERT ${CERT_NAME}"
cp ${WORKING_DIR}/${CERT_NAME}.crt ${CERT_DIR}/${CERT_NAME}/${CERT_NAME}.crt

ls -l ${CERT_DIR}/${CERT_NAME}

echo "UPDATE CERTS:"
update-ca-certificates

