# Intel aero docker image for Ubuntu

See [intel-aero-ubuntu-docker/README.md](intel-aero-ubuntu-docker/README.md) for instructions.

# Repository for creating a yocto image with ROS installation

This repository was an unsuccessful attempt to build a yocto image with ROS
installation. This meant combining instructions from openembedded.org,
yoctoproject.org, https://github.com/intel-aero/meta-intel-aero, and
https://github.com/bmwcarit/meta-ros to compile a single intel image.
The most challenging part of this was that meta-ros and meta-intel-aero
do not explicitly specific which yocto
[version](https://wiki.yoctoproject.org/wiki/Releases) do they explicity
support. Unlike other openembedded `meta-x` repositories, meta-ros and
meta-intel-aero do not have similar branch names. I tried sumo and rocko.


# Prefer meta-intel instructions rather than meta-intel-aero for dd

+ Find the usb disk using `lsblk` or `mount | grep sda`
+ Make sure the disk-partitions are all unmounted `umount /dev/sdx1`
+ `sudo dd if=/dev/zero of=/dev/sdx bs=1M count=512`
+ `sudo dd if=${HOME}/Downloads/intel-aero-image-1.6.2.iso of=/dev/sdx bs=1M`
+ `sync`
+ `eject /dev/sda`

# How to connect to UCSD-PROTECTED using commandline (nmcli)

    nmcli con add type wifi con-name UCSD-PROTECTED ifname wlp1s0 ssid UCSD-PROTECTED -- ipv4.method auto wifi-sec.key-mgmt wpa-eap 802-1x.eap peap 802-1x.identity '<ucsd username>' 802-1x.phase2-auth mschapv2 802-1x.password '<your active directory password>'
    
WARNING: your password is stored in plain text at `/etc/NetworkManager/system-connections/UCSD-PROTECTED`. After you are done, you might want to delete `~/.bash_history` and `/etc/NetworkManager/system-connections/UCSD-PROTECTED`
