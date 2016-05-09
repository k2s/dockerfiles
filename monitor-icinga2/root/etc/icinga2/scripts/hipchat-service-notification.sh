#!/bin/bash

if [ -n "$HIPCHAT_TOKEN" ]; then
    hipsaint --user=Icinga --token=$HIPCHAT_TOKEN --room=$HIPCHAT_ROOM_ID --type=service --inputs="$SERVICEDESC|$HOSTALIAS|$LONGDATETIME|$NOTIFICATIONTYPE|$HOSTADDRESS|$SERVICESTATE|$SERVICEOUTPUT" -n
fi
