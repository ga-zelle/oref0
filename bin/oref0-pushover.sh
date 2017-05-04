#!/bin/bash

TOKEN=$1
USER=$2
FILE={$3-enact/smb-suggested.json}
SOUND={$4-none}
SNOOZE={$5-15}

if ! find monitor/ -mmin -$SNOOZE -ls | grep pushover-sent && cat $FILE | egrep "add'l|maxBolus"
    curl -s -F "token=$TOKEN" -F "user=$USER" -F "sound=$SOUND" -F "message=$(jq -c "{bg, tick, carbsReq, insulinReq, reason}|del(.[] | nulls)" $FILE)" https://api.pushover.net/1/messages.json && touch monitor/pushover-sent
fi
