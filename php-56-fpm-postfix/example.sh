#!/bin/bash

echo "sending dummy mail"
php -f /xt/tools/mail_test.php -- test@example.com

echo "waiting for delivery and shutting down"
/xt/tools/shutdown.sh