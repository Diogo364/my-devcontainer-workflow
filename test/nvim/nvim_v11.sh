#!/bin/bash

set -e

source dev-container-features-test-lib

# Check Neovim Version
check 'Neovim Version' nvim --version | grep -o 'v0.11.1'
