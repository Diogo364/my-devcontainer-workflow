#!/bin/bash
#-------------------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://github.com/devcontainers/features/blob/main/LICENSE for license information.
#-------------------------------------------------------------------------------------------------------------------------
#
# Docs: https://github.com/devcontainers/features/tree/main/src/common-utils
# Maintainer: The Dev Container spec maintainers

# this was taken from the main devcontainer-features repo at:
# https://github.com/devcontainers/features/
set -e

export UPGRADE_PACKAGES="${UPGRADEPACKAGES:-"true"}"
export INSTALL_FD="${INSTALLFD:-"true"}"
export INSTALL_RG="${INSTALLRG:-"true"}"
export INSTALL_NPM="${INSTALLNPM:-"true"}"
export INSTALL_TMUX="${INSTALLTMUX:-"true"}"


if [[ "$(id -u)" -ne 0 ]]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

exec /bin/bash "$(dirname $0)/main.sh" "$@"
exit $?
