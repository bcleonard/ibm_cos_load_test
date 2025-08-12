#!/bin/bash -x

SCRIPT_DIR="/usr/local/scripts"
OG=/usr/local/og/og
WIPE_CMD="${SCRIPT_DIR}/wipe_buckets.sh"

echo "RUNNING TESTS for ${MODE} mode."
INITIAL_CONFIG="${SCRIPT_DIR}/${MODE}_init_test.json"
LOADTEST_CONFIG="${SCRIPT_DIR}/${MODE}_load_test.json"

echo "WIPING DATA in ${MODE} mode."
${WIPE_CMD}

echo "PERFORMING INITIAL LOAD in ${MODE} mode."
${OG} ${INITIAL_CONFIG}

echo "PERFORMING LOAD TEST in ${MODE} mode."
${OG} ${LOADTEST_CONFIG}

echo "WIPING DATA in ${MODE} mode."
${WIPE_CMD}

exit

