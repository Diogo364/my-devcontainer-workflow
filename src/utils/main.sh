#!/bin/bash
#-------------------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://github.com/devcontainers/features/blob/main/LICENSE for license information.
#-------------------------------------------------------------------------------------------------------------------------
#
# Docs: https://github.com/devcontainers/features/tree/main/src/common-utils
# Maintainer: The Dev Container spec maintainers

set -e

export MARKER_DIR="/usr/local/etc/devcontainer-build"
export MARKER_FILE="$MARKER_DIR/vars"

FEATURE_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# ******************
# ** Main section **
# ******************

if [[ "$(id -u)" -ne 0 ]]; then
    echo -e 'Script must be run as root. Use sudo, su, or add "USER root" to your Dockerfile before running this script.'
    exit 1
fi

# Load markers to see which steps have already run
if [[ -f "${MARKER_FILE}" ]]; then
    echo "Marker file found:"
    cat "${MARKER_FILE}"
    source "${MARKER_FILE}"
else
    mkdir -p $(dirname ${MARKER_DIR})
fi

# Bring in ID, ID_LIKE, VERSION_ID, VERSION_CODENAME
. /etc/os-release
# Get an adjusted ID independent of distro variants
if [[ "${ID}" = "debian" ]] || [[ "${ID_LIKE}" = "debian" ]]; then
    export ADJUSTED_ID="debian"
elif [[ "${ID}" = "alpine" ]]; then
    export ADJUSTED_ID="alpine"
else
    echo "Linux distro ${ID} not supported."
    exit 1
fi

echo "Using ADJUSTED_ID as $ADJUSTED_ID"
if [[ ${UPGRADE_PACKAGES} = 'true' ]]; then
    bash -c "$(dirname $0)/script/install.sh" "$@"
fi

echo "Done installing"

# ****************************
# ** Utilities and commands **
# ****************************

# Write marker file
if [[ ! -d "${MARKER_DIR}" ]]; then
    echo "Creating Marker file path"
    mkdir -p "${MARKER_DIR}"
fi
echo -e "\
UPGRADE_PACKAGES=${UPGRADE_PACKAGES}" > "${MARKER_FILE}"

if [[ ${INSTALL_FD} = "true" ]]; then
    sudo apt install -y fd-find
    ln -s $(which fdfind) /usr/local/bin/fd
fi
echo -e "INSTALL_FD=${INSTALL_FD}\n" >> "${MARKER_FILE}"

if [[ ${INSTALL_RG} = "true" ]]; then
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
    dpkg -i ripgrep_14.1.0-1_amd64.deb
fi
echo -e "INSTALL_RG=${INSTALL_RG}\n" >> "${MARKER_FILE}"

if [[ ${INSTALL_NPM} = "true" ]]; then
    apt install -y nodejs
    apt install -y npm
fi
echo -e "INSTALL_NPM=${INSTALL_NPM}\n" >> "${MARKER_FILE}"


if [[ ${INSTALL_TMUX} = "true" ]]; then
    apt install -y tmux

fi
echo -e "INSTALL_TMUX=${INSTALL_TMUX}\n" >> "${MARKER_FILE}"

cat "${MARKER_FILE}"
