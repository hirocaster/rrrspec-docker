#!/bin/sh

set -e

cd /opt/project

bundle install

TASK_KEY=$(bundle exec rrrspec-client start --rsync-name "${USER}" --key-only)
bundle exec rrrspec-client waitfor $TASK_KEY --pollsec=10
exec bundle exec rrrspec-client show $TASK_KEY --verbose --failure-exit-code=1
