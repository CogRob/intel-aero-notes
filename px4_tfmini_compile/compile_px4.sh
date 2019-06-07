#!/bin/bash

set -e

# http://stackoverflow.com/questions/59895/can-a-bash-script-tell-which-directory-it-is-stored-in
CURRENT_SCRIPT="${BASH_SOURCE[0]}"
while [ -h "$CURRENT_SCRIPT" ]; do # resolve $CURRENT_SCRIPT until the file is no longer a symlink
  CURRENT_SCRIPT_PATH="$( cd -P "$( dirname "$CURRENT_SCRIPT" )" && pwd )"
  CURRENT_SCRIPT="$(readlink "$CURRENT_SCRIPT")"
  # if $CURRENT_SCRIPT was a relative symlink, we need to resolve it relative to the path where the symlink file was located
  [[ $CURRENT_SCRIPT != /* ]] && CURRENT_SCRIPT="$CURRENT_SCRIPT_PATH/$CURRENT_SCRIPT"
done
CURRENT_SCRIPT_PATH="$( cd -P "$( dirname "$CURRENT_SCRIPT" )" && pwd )"

cd $CURRENT_SCRIPT_PATH
rm -rf PX4_Firmware
git clone -b v1.9.0-rc1 https://github.com/PX4/Firmware.git PX4_Firmware
sed -i "s/_min_distance(0.30f)/_min_distance(0.10f)/g" PX4_Firmware/src/drivers/distance_sensor/tfmini/tfmini.cpp
sed -i "s/_min_distance = 0.3f/_min_distance = 0.1f/g" PX4_Firmware/src/drivers/distance_sensor/tfmini/tfmini.cpp
./PX4_Firmware/Tools/docker_run.sh 'make intel_aerofc-v1_default'
cp PX4_Firmware/build/intel_aerofc-v1_default/intel_aerofc-v1_default.px4 intel_aerofc-v1_default-$(date +%s).px4
