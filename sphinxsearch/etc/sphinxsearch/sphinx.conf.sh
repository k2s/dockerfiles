#!/usr/bin/env bash

echo "# SPHINX_CONFIG:"

DIR=$(dirname $0)

# main configuration options
cat $SPHINXSEARCH_CONFIG_MAIN

#other configuration files
for folder in "${SPHINXSEARCH_CONFIG_D[@]}"
do
	if [ -d $folder ]; then
		find $folder -name '*.conf' | while read fname; do
			if [ -x $fname ]; then
				echo "# EXECUTE: $fname"
				$fname
			elif [ -f $fname ]; then
				echo "# INCLUDE: $fname"
				cat $fname
			fi
		done
  else
		echo "# config folder '$folder' not found"
	fi
done


echo "# .SPHINX_CONFIG"%