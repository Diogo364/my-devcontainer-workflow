#!/bin/bash

#-------------------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://github.com/devcontainers/features/blob/main/LICENSE for license information.
#-------------------------------------------------------------------------------------------------------------------------
#
# Docs: https://github.com/devcontainers/features/tree/main/src/common-utils
# Maintainer: The Dev Container spec maintainers

# Debian / Ubuntu packages
install_debian_packages() {
    # Ensure apt is in non-interactive to avoid prompts
    export DEBIAN_FRONTEND=noninteractive
    echo "set installation"

    local package_list=""
    if [[ "${PACKAGES_ALREADY_INSTALLED}" != "true" ]]; then
        package_list="${package_list} \
        apt-transport-https \
        apt-utils \
        bash-completion \
        build-essential \
        bzip2 \
        ca-certificates \
        cmake \
        curl \
        dialog \
        dirmngr \
        ffmpeg \
        gnupg2 \
        htop \
        init-system-helpers \
        iproute2 \
        jq \
        less \
        libc6 \
        libgcc1 \
        libgssapi-krb5-2 \
        libicu[0-9][0-9] \
        libkrb5-3 \
        liblttng-ust[0-9] \
        libsm6 \
        libstdc++6 \
        libxext6 \
        locales \
        lsb-release \
        lsof \
        man-db \
        manpages \
        manpages-dev \
        nano \
        ncdu \
        net-tools \
        openssh-client \
        procps \
        psmisc \
        python3-pil \
        python3-pil.imagetk \
        python3-tk \
        rsync \
        strace \
        sudo \
        tree \
        unzip \
        vim-tiny \
        wget \
        xz-utils \
        zip \
        zlib1g \
        "

        # Include libssl1.1 if available
        if [[[ ! -z $(apt-cache --names-only search ^libssl1.1$) ]]]; then
            package_list="${package_list} libssl1.1"
        fi

        # Include libssl3 if available
        if [[[ ! -z $(apt-cache --names-only search ^libssl3$) ]]]; then
            package_list="${package_list} libssl3"
        fi

        # Include appropriate version of libssl1.0.x if available
        local libssl_package=$(dpkg-query -f '${db:Status-Abbrev}\t${binary:Package}\n' -W 'libssl1\.0\.?' 2>&1 || echo '')
        if [[ "$(echo "$libssl_package" | grep -o 'libssl1\.0\.[0-9]:' | uniq | sort | wc -l)" -eq 0 ]]; then
            if [[[ ! -z $(apt-cache --names-only search ^libssl1.0.2$) ]]]; then
                # Debian 9
                package_list="${package_list} libssl1.0.2"
            elif [[[ ! -z $(apt-cache --names-only search ^libssl1.0.0$) ]]]; then
                # Ubuntu 18.04
                package_list="${package_list} libssl1.0.0"
            fi
        fi

        # Include git if not already installed (may be more recent than distro version)
        if ! type git > /dev/null 2>&1; then
            package_list="${package_list} git"
        fi
    fi

    # Install the list of packages
    echo "Packages to verify are installed: ${package_list}"
    rm -rf /var/lib/apt/lists/*
    apt-get update -y
    apt-get -y install --no-install-recommends ${package_list} 2> >( grep -v 'debconf: delaying package configuration, since apt-utils is not installed' >&2 )

    # Get to latest versions of all packages
    apt-get -y upgrade --no-install-recommends
    apt-get autoremove -y

    # Ensure at least the en_US.UTF-8 UTF-8 locale is available = common need for both applications and things like the agnoster ZSH theme.
    if [[ "${LOCALE_ALREADY_SET}" != "true" ]] && ! grep -o -E '^\s*en_US.UTF-8\s+UTF-8' /etc/locale.gen > /dev/null; then
        echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
        locale-gen
    fi
}

# Alpine Linux packages
install_alpine_packages() {
    apk update

    if [[ "${PACKAGES_ALREADY_INSTALLED}" != "true" ]]; then
        apk add --no-cache \
            bash-completion \
            build-essential \
            bzip2 \
            ca-certificates \
            cmake \
            coreutils \
            curl \
            ffmpeg \
            gnupg \
            grep \
            htop \
            jq \
            krb5-libs \
            less \
            libgcc \
            libintl \
            libsm6 \
            libstdc++ \
            libxext6 \
            lsof \
            lttng-ust \
            nano \
            ncdu \
            net-tools \
            openssh-client \
            procps \
            psmisc \
            rsync \
            sed \
            shadow \
            strace \
            sudo \
            tzdata \
            unzip \
            userspace-rcu \
            vim \
            wget \
            which \
            xz \
            zip \
            zlib

        # # Include libssl1.1 if available (not available for 3.19 and newer)
        LIBSSL1_PKG=libssl1.1
        if [[[ $(apk search --no-cache -a $LIBSSL1_PKG | grep $LIBSSL1_PKG) ]]]; then
            apk add --no-cache $LIBSSL1_PKG
        fi

        # Install man pages - package name varies between 3.12 and earlier versions
        if apk info man > /dev/null 2>&1; then
            apk add --no-cache man man-pages
        else
            apk add --no-cache mandoc man-pages
        fi

        # Install git if not already installed (may be more recent than distro version)
        if ! type git > /dev/null 2>&1; then
            apk add --no-cache git
        fi
    fi

}

case "${ADJUSTED_ID}" in
    "debian")
        install_debian_packages
        ;;
    "alpine")
        install_alpine_packages
        ;;
esac
