#!/usr/bin/env bash

# see:
# https://pear.php.net/bugs/bug.php?id=21020
# https://pear.php.net/manual/en/guide.users.commandline.installing.php
# http://svn.php.net/viewvc/pear/packages/SQL_Parser/trunk/

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd /tmp
svn checkout http://svn.php.net/repository/pear/packages/SQL_Parser/trunk SQL_Parser
cd SQL_Parser
pear package package.xml
mv SQL_Parser-0.6.0.tgz $DIR/
