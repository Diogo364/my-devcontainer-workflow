#!/bin/bash

set -e

source dev-container-features-test-lib

check "Check UPGRADE_PACKAGES" $(awk -F"=" \
        '/UPGRADE_PACKAGES/ {print $2}' \
        /usr/local/etc/devcontainer-build/vars \
        | grep -o "false")

check "fd installed?" fd --version

check "rg installed?" rg --version

check "npm installed?" npm -v

check "tmux installed?" tmux -V

reportResults
