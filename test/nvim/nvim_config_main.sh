#!/bin/bash

set -e

source dev-container-features-test-lib

cd /root/.config/nvim
check 'Neovim Config Repo' git branch | grep -o '* main'
