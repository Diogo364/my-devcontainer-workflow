#!/bin/bash

set -e

source dev-container-features-test-lib

check 'Custom home exists' test -d /custom
check 'Custom .config exists' test -d /custom/.config
