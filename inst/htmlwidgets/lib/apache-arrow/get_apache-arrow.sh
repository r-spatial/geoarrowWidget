#!/bin/sh

BASEURL="https://cdn.jsdelivr.net/npm/apache-arrow"

# get (latest) dep
# see https://stackoverflow.com/a/38795701/2555983 for --backups
# basically keeps the last one as backup but
wget --backups=1 ${BASEURL}/Arrow.es2015.min.js
rm *.js.1

# get LICENSE and NOTE if available
license_status_code=$(curl -s -o /dev/null -w "%{http_code}" ${BASEURL}'/LICENSE')
notice_status_code=$(curl -s -o /dev/null -w "%{http_code}" ${BASEURL}'/NOTICE.txt')

if [ $license_status_code -eq 200 ]; then
  rm LICENSE;
  curl -s ${BASEURL}'/LICENSE' > LICENSE; 
fi

if [ $notice_status_code -eq 200 ]; then 
  rm NOTICE.txt;
  curl -s ${BASEURL}'/NOTICE.txt' > NOTICE.txt; 
fi

# get (latest) version
curl -s ${BASEURL}'/package.json' | jq -r '.version' > version.txt
