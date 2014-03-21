#!/usr/bin/env bash
#
# Simple hack to update /etc/sudoers for Ubuntu so that vagrant can run commands
# as root without requiring a password.
#
# I would be happier if the User ID was configurable instead of hard coded.
# Also prefer if the command executed conditionally, so this could deal with all Distro specific things
# not just this one issue.
#
(more /etc/sudoers && echo "vagrant ALL=(ALL) NOPASSWD: ALL")  > ~/at
