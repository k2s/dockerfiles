#!/bin/bash

if [ -n "$HIPCHAT_TOKEN" ]; then
    hipsaint --user=Icinga --token=$HIPCHAT_TOKEN --room=$HIPCHAT_ROOM_ID --type=host --inputs="$HOSTNAME|$LONGDATETIME|$NOTIFICATIONTYPE|$HOSTADDRESS|$HOSTSTATE|$HOSTOUTPUT" -n
fi
