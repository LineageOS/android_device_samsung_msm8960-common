#!/bin/bash
#
# Copyright (C) 2016 The CyanogenMod Project
# Copyright (C) 2017 The LineageOS Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

set -e

export INITIAL_COPYRIGHT_YEAR=2012
export MSM8960_DEVICE_LIST="apexqtmo comanche d2att d2bst d2cri d2csp d2mtr d2refreshspr d2spr d2tmo d2usc d2vzw espressovzw expressatt"
export D2_DEVICE_LIST="d2att d2bst d2cri d2csp d2mtr d2refreshspr d2spr d2tmo d2usc d2vzw"
export D2_GSM_LIST="d2att d2tmo"
export D2_R530_LIST="d2cri d2csp d2usc"

# Load extract_utils and do some sanity checks
MY_DIR="${BASH_SOURCE%/*}"
if [[ ! -d "$MY_DIR" ]]; then MY_DIR="$PWD"; fi

CM_ROOT="$MY_DIR"/../../..

HELPER="$CM_ROOT"/vendor/cm/build/tools/extract_utils.sh
if [ ! -f "$HELPER" ]; then
    echo "Unable to find helper script at $HELPER"
    exit 1
fi
. "$HELPER"

# Initialize the helper for common platform
setup_vendor "$PLATFORM_COMMON" "$VENDOR" "$CM_ROOT" true

# Copyright headers and common guards for msm8960-common
write_headers "$MSM8960_DEVICE_LIST"

# The standard blobs
write_makefiles "$MY_DIR"/proprietary-files.txt

# We are done with msm8960-common
write_footers

if [ "$DEVICE_COMMON" == "d2-common" ]; then
# Reinitialize the helper for common device
setup_vendor "$DEVICE_COMMON" "$VENDOR" "$CM_ROOT" true

# Copyright headers and guards for d2-common
write_headers "$D2_DEVICE_LIST"

write_makefiles "$MY_DIR"/../$DEVICE_COMMON/proprietary-files.txt

# We are done with d2-common
write_footers
fi


if [ "$DEVICE" == "d2att" ] ||
                [ "$DEVICE" == "d2tmo" ]; then
    export BLOB_LOC=d2gsm
elif [ "$DEVICE" == "d2cri" ] ||
                [ "$DEVICE" == "d2scp" ] ||
                [ "$DEVICE" == "d2usc" ]; then
    export BLOB_LOC=d2r530
else
    export BLOB_LOC=$DEVICE
fi

if [ "$BLOB_LOC" != "$DEVICE" ]; then
# Reinitialize the helper for device with commonized ril
setup_vendor "$BLOB_LOC" "$VENDOR" "$CM_ROOT" true
else
# Reinitialize the helper for device without commonized ril
setup_vendor "$BLOB_LOC" "$VENDOR" "$CM_ROOT"
fi

# Copyright headers and guards
if [ "$BLOB_LOC" == "d2gsm" ]; then
write_headers "$D2_GSM_LIST"
elif [ "$BLOB_LOC" == "d2r530" ]; then
write_headers "$D2_R530_LIST"
else
write_headers "$DEVICE"
fi

write_makefiles "$MY_DIR"/../$DEVICE/proprietary-files.txt

# We are done with device
write_footers
