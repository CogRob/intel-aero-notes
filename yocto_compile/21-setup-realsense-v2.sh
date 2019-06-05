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

rm -rf meta-intel-realsense-v2
git clone https://github.com/IntelRealSense/meta-intel-realsense.git meta-intel-realsense-v2
grep "meta-intel-realsense-v2" poky/build/conf/bblayers.conf || echo 'BBLAYERS += "/intel_aero/poky/../meta-intel-realsense-v2"' >> poky/build/conf/bblayers.conf

echo 'require include/intel-librealsense.inc' > poky/build/conf/auto.conf
echo 'CORE_IMAGE_EXTRA_INSTALL += "librealsense2 librealsense2-tools"' >> poky/build/conf/auto.conf
echo 'CORE_IMAGE_EXTRA_INSTALL += "librealsense2-debug-tools"' >> poky/build/conf/auto.conf
echo 'CORE_IMAGE_EXTRA_INSTALL += "librealsense2-examples"' >> poky/build/conf/auto.conf

echo 'FILES_${PN} += "/usr/lib/cmake/*"' >> meta-intel-realsense-v2/recipes-support/librealsense/librealsense2.inc
