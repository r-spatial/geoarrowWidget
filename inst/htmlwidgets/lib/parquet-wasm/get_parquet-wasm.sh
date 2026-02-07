#!/bin/sh

BASEURL="https://cdn.jsdelivr.net/npm/parquet-wasm"

# get (latest) dep
# see https://stackoverflow.com/a/38795701/2555983 for --backups
# basically keeps the last one as backup
curl -s ${BASEURL}"/esm/+esm" > parquet-wasm.min.js

# get LICENSE and NOTE if available
license_status_code=$(curl -s -o /dev/null -w "%{http_code}" ${BASEURL}'/LICENSE_MIT')

if [ $license_status_code -eq 200 ]; then
  rm LICENSE;
  curl -s ${BASEURL}'/LICENSE_MIT' > LICENSE_MIT; 
fi

# get (latest) version
curl -s ${BASEURL}'/package.json' | jq -r '.version' > version.txt
