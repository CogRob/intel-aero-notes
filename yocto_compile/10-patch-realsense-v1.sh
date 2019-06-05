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

cd $CURRENT_SCRIPT_PATH/intel_aero/meta-intel-aero/recipes-support/librealsense
rm -f librealsense_1.12.1.bbappend librealsense.inc librealsense_1.12.0.bb
wget https://raw.githubusercontent.com/IntelRealSense/meta-intel-librealsense/master/recipes-support/librealsense/librealsense.inc
wget https://raw.githubusercontent.com/IntelRealSense/meta-intel-librealsense/master/recipes-support/librealsense/librealsense_1.12.0.bb
sed -i "s/branch=master/branch=legacy/g" librealsense_1.12.0.bb
