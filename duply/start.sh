#!/bin/bash
set -e

# if no args supplied then show help
[ -z "$1" ] && exec /usr/bin/duply usage

# append some duplicity-specific options that we need.
# The allow-source-mismatch option is required since each time we run
# we're effectively on a different (virtual) host.
exec /usr/bin/duply $@ --allow-source-mismatch
