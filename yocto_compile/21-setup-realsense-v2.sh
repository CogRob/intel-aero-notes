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

cd $CURRENT_SCRIPT_PATH/intel_aero

git clone https://github.com/IntelRealSense/meta-intel-realsense.git meta-intel-realsense-v2
echo 'BBLAYERS += "/intel_aero/poky/../meta-intel-realsense-v2"' >> intel_aero/poky/build/conf/bblayers.conf

echo 'require include/intel-librealsense.inc' > intel_aero/poky/build/conf/auto.conf
echo 'CORE_IMAGE_EXTRA_INSTALL += "librealsense2 librealsense2-tools"' >> intel_aero/poky/build/conf/auto.conf
echo 'CORE_IMAGE_EXTRA_INSTALL += "librealsense2-debug-tools"' >> intel_aero/poky/build/conf/auto.conf
echo 'CORE_IMAGE_EXTRA_INSTALL += "librealsense2-examples"' >> intel_aero/poky/build/conf/auto.conf
