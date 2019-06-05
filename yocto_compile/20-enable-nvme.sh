#!/bin/bash

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in
CURRENT_SCRIPT="${BASH_SOURCE[0]}"
while [ -h "$CURRENT_SCRIPT" ]; do # resolve $CURRENT_SCRIPT until the file is no longer a symlink
  CURRENT_SCRIPT_PATH="$( cd -P "$( dirname "$CURRENT_SCRIPT" )" && pwd )"
  CURRENT_SCRIPT="$(readlink "$CURRENT_SCRIPT")"
  # if $CURRENT_SCRIPT was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  [[ $CURRENT_SCRIPT != /* ]] && CURRENT_SCRIPT="$CURRENT_SCRIPT_PATH/$CURRENT_SCRIPT"
done
CURRENT_SCRIPT_PATH="$( cd -P "$( dirname "$CURRENT_SCRIPT" )" && pwd )"

sed -i "s/^.*CONFIG_BLK_DEV_NVME.*$/CONFIG_BLK_DEV_NVME=m/g" $CURRENT_SCRIPT_PATH/intel_aero/meta-intel-aero-base/recipes-kernel/linux/linux-yocto/defconfig
