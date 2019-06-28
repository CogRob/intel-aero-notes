# Compiling yocto image with nvme drivers and customizations

Run the shell scripts in this directory in the order of the number in front of filename

``` shellsession

$ for scr in *.sh; do bash $scr; done
```

If everything succeeds the intel-aero-image should be in found as:

``` shellsession
$ ls intel_aero/poky/build/tmp/deploy/images/intel-aero/*.iso
intel_aero/poky/build/tmp/deploy/images/intel-aero/intel-aero-image-intel-aero-20190628211219.iso
intel_aero/poky/build/tmp/deploy/images/intel-aero/intel-aero-image-intel-aero.iso
```

Mount the iso image to a usb drivers

``` shellsession
$ sudo dd if=intel_aero/poky/build/tmp/deploy/images/intel-aero/intel-aero-image-intel-aero-*.iso of=/dev/sdX bs=1M
```
where `/dev/sdX` is the device name for your usb drive. `lsblk -f` is your friend.

