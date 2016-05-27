#!/bin/sh

set -e

cd /opt/project

bundle install

TASK_KEY=$(bundle exec rrrspec-client start --config /opt/lib/rrrspec-server-config.rb --rsync-name "${USER}" --key-only)
bundle exec rrrspec-client waitfor $TASK_KEY --config /opt/lib/rrrspec-server-config.rb --pollsec=10
exec bundle exec rrrspec-client show $TASK_KEY --config /opt/lib/rrrspec-server-config.rb --verbose --failure-exit-code=1
