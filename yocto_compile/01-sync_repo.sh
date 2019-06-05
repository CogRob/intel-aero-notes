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

rm -rf $CURRENT_SCRIPT_PATH/intel_aero
mkdir -p $CURRENT_SCRIPT_PATH/intel_aero

docker run --rm --volume $CURRENT_SCRIPT_PATH/intel_aero:/intel_aero --workdir /intel_aero cogrob_yocto_compile:local \
  repo init -u https://github.com/intel-aero/intel-aero-manifest.git -m v1.6.2.xml -b master

docker run --rm --volume $CURRENT_SCRIPT_PATH/intel_aero:/intel_aero --workdir /intel_aero cogrob_yocto_compile:local \
  repo sync -j4

docker run --rm --volume $CURRENT_SCRIPT_PATH/intel_aero:/intel_aero --workdir /intel_aero cogrob_yocto_compile:local \
  chown -R `id -ru`:`id -rg` /intel_aero
