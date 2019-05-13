# Use Optical Flow + LiDAR on Drones

## TFMini Plus

### Buy from Amazon

https://www.amazon.com/s?k=tfmini+plus&ref=nb_sb_noss_1

https://www.amazon.com/TFmini-Waterproof-Finder-Sensor-Anti-dust/dp/B07L8B2FVK/ref=sr_1_fkmrnull_2?keywords=tfmini+plus&qid=1557710231&s=gateway&sr=8-2-fkmrnull


### Prepare the Connection

Get the TFMini manual from:
https://cdn.sparkfun.com/assets/1/4/2/1/9/TFmini_Plus_A02_Product_Manual_EN.pdf
See page 11, 5.1

The Intel manual from:
https://www.intel.com/content/dam/support/us/en/documents/drones/development-drones/intel-aero-compute-board-guide.pdf
See page 15, 3.8.5 (J5, Telemetry 1)

Use the splitter from the GPS bag, get the 1mmx6 male connector, take the pins
out with tweezers (patience!), and put in the pins from the TFMini Plus.


## Compile the latest PX4 firmware

https://github.com/PX4/Firmware

Use the latest released version: https://github.com/PX4/Firmware/releases

```
git checkout v1.9.0-rc1
./Tools/docker_run.sh 'make intel_aerofc-v1_default'
```

Transfer to the drone.
```
scp build/intel_aerofc-v1_default/intel_aerofc-v1_default.px4 root@192.168.8.1:.
# On the drone
aerofc-update.sh intel_aerofc-v1_default.px4
```

## Configure the PX4

With QGroundControl, set
```
SENS_TFMINI_CFG = 101 (TELEM1)
EKF2_AID_MASK = 3 (use GPS + use optical flow)
EKF2_HGT_MODE = 2 (range sensor)
```

See: https://github.com/intel-aero/aero-optical-flow


## Enable optical flow
```
systemctl start aero-optical-flow.service
systemctl enable aero-optical-flow.service
```

Do a `ps aux | grep flow` to make sure it is running. To troubleshot:
- Disconnect and reconnect the camera
- Load optimal options in the BIOS
- Make sure video streaming work (not working when running optical flow)
- Make sure use Yocto 1.6.2 (https://github.com/intel-aero/aero-optical-flow/issues/4)


## Put the drone into "Position Mode" and fly

Good luck.
