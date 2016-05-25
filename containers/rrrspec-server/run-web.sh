#!/bin/sh

set -e

cd /opt/rrrspec/rrrspec-web ; bundle exec unicorn
