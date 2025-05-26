#!/bin/bash

# this was taken from duduribeiro devcontainer-features at:
# https://github.com/duduribeiro/devcontainer-features/blob/main/src/neovim/install.sh
set -e
echo "Activating feature 'neovim'"

HOME="${HOME:-"/root"}"
NVIM_CLONE_CONFIG="${NVIMCLONECONFIG:-"true"}"
NVIM_CONFIG_REPO="${NVIMCONFIGREPO:-https://github.com/Diogo364/my-nvim.git}"
NVIM_CONFIG_BRANCH="${NVIMCONFIGBRANCH:-lean}"
NVIM_DIR="${NVIMDIR:-nvim-linux-x86_64}"
NVIM_INSTALLER="${NVIMINSTALLER:-https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz}"
INSTALL_DIR="${INSTALLDIR:-/tmp}"

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"
export TERM="xterm-256color"
export DISPLAY="unix:${DISPLAY}"

log_vars() {
    echo "
    HOME=${HOME}
    NVIM_CLONE_CONFIG=${NVIM_CLONE_CONFIG}
    NVIM_CONFIG_REPO=${NVIM_CONFIG_REPO}
    NVIM_CONFIG_BRANCH=${NVIM_CONFIG_BRANCH}
    NVIM_DIR=${NVIM_DIR}
    NVIM_INSTALLER=${NVIM_INSTALLER}
    XDG_CONFIG_HOME=${XDG_CONFIG_HOME}
    XDG_DATA_HOME=${XDG_DATA_HOME}
    XDG_STATE_HOME=${XDG_STATE_HOME}
    TERM=${TERM}
    DISPLAY=${DISPLAY}
    " > /var/log/devcontainer.log
}

# ******************
# ** Main section **
# ******************

# Install dependencies
source $(dirname $0)/install_dependencies.sh
echo "now continue"

mkdir -p ${XDG_CONFIG_HOME} ${XDG_DATA_HOME} ${XDG_STATE_HOME}
chmod -R a+rwx ${XDG_CONFIG_HOME}

cd "${INSTALL_DIR}"

# Install nvim
wget "${NVIM_INSTALLER}"
tar -xzvf ${NVIM_DIR}.tar.gz
sudo ln -s "${INSTALL_DIR}/${NVIM_DIR}/bin/nvim" /usr/local/bin/nvim

# Clone config
if [ ${NVIM_CLONE_CONFIG} = 'true' ]; then
    echo "Cloning specific config"
    git clone ${NVIM_CONFIG_REPO} -b ${NVIM_CONFIG_BRANCH} ${XDG_CONFIG_HOME}/nvim
fi

log_vars
