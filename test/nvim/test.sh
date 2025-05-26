#!/bin/bash

set -e

source dev-container-features-test-lib

# Check Neovim Version
check 'Neovim Version' nvim --version | grep -o 'v0.10.4'

# Check Neovim Config on Lean branch
cd /root/.config/nvim
check 'Neovim Config Repo' git branch | grep -o '* lean'

reportResults
