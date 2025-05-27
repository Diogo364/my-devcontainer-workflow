#!/bin/bash

package_list="${package_list} \
sudo \
luarocks \
imagemagick \
libmagickwand-dev \
git \
curl \
wget \
tar \
python3-venv \
python3-neovim \
python3-dev \
python3-pip \
build-essential"

# Debian / Ubuntu dependencies
install_debian_dependencies() {
    export DEBIAN_FRONTEND=noninteractive
    if ! command -v npm; then
        package_list="${package_list} \
nodejs \
npm"
    fi

    rm -rf /var/lib/apt/lists/*
    apt-get update -y
    apt-get -y install --no-install-recommends ${package_list}

    # Clean up
    apt-get -y clean
    rm -rf /var/lib/apt/lists/*
}

# Bring in ID, ID_LIKE, VERSION_ID, VERSION_CODENAME
. /etc/os-release
# Get an adjusted ID independent of distro variants
if [ "${ID}" = "debian" ] || [ "${ID_LIKE}" = "debian" ]; then
    ADJUSTED_ID="debian"
else
    echo "Linux distro ${ID} not supported."
    exit 1
fi

# Install packages for appropriate OS
case "${ADJUSTED_ID}" in
    "debian")
        install_debian_dependencies
        ;;
esac
echo "done"
