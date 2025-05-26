#!/bin/bash

package_list="${package_list} \
sudo \
git \
curl \
wget \
tar \
python3-venv \
build-essential"

# Debian / Ubuntu dependencies
install_debian_dependencies() {
    export DEBIAN_FRONTEND=noninteractive

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
