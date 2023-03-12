#!/bin/bash

set +o history
set -o posix
set -b
set -C
set -p

pid_string="$(pgrep -f -d ' ' python3 | xargs echo -n) ${pid_string}"

for p in ${pid_string}
do
   sudo kill -9 "${p}" 2>/dev/null
done

echo 'Closed!'
