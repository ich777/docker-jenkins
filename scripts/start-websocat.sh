#!/bin/bash
if [ -z "${WAITFOR_WS}" ]; then
  sleep 10
else
  sleep ${WAITFOR_WS}
fi

if [ -z "${WS_RESTART_SLEEP}" ]; then
  WS_RESTART_SLEEP=10
fi

while true; do
  websocat -E ${WEB_SOCKET} | while read line; do
    NOTIFY_TITLE=$(echo $line | jq -r '.project')
    BUILD_NO=$(echo $line | jq -r '.number')
    RESULT=$(echo $line | jq -r '.result')
    if [ "${RESULT}" == "SUCCESS" ]; then
      NOTIFY_PRIORITY=1
      if [ "${MSG_ON_SUCCESS}" == "true" ]; then
        wget -qO- "${NOTIFY_URL}message?token=${NOTIFY_TOKEN}" --post-data "title=${NOTIFY_TITLE}&message=BUILD #${BUILD_NO} (${RESULT})&priority=${NOTIFY_PRIORITY}" &>/dev/null
      fi
    else
      NOTIFY_PRIORITY=21
      wget -qO- "${NOTIFY_URL}message?token=${NOTIFY_TOKEN}" --post-data "title=${NOTIFY_TITLE}&message=BUILD #${BUILD_NO} (${RESULT})&priority=${NOTIFY_PRIORITY}" &>/dev/null
    fi
  done
  echo "---Retrying in ${WS_RESTART_SLEEP} seconds!---"
  sleep ${WS_RESTART_SLEEP}
done