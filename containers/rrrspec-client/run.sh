#!/bin/sh

set -e

cd /opt/project

TASK_KEY=$(rrrspec-client start --config /opt/lib/rrrspec-server-config.rb --rsync-name "${USER}" --key-only)
rrrspec-client waitfor $TASK_KEY --config /opt/lib/rrrspec-server-config.rb --pollsec=10
exec rrrspec-client show $TASK_KEY --config /opt/lib/rrrspec-server-config.rb --verbose --failure-exit-code=1
