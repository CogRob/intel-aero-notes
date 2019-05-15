# Use NVMe under Yocto

ONLY IF YOU ARE USING INTEL YOCTO 1.6.2

Copy the `nvme` directory to
```
/lib/modules/4.4.113-yocto-standard/kernel/drivers
```


## Where does it come from

Build Yocto

https://github.com/intel-aero/meta-intel-aero/wiki/96-(References)-Rebuild-Yocto

https://forums.intel.com/s/question/0D50P0000490XldSAE/cannot-build-v162-with-yocto?language=en_US


In
```
meta-intel-aero-base/recipes-kernel/linux/linux-yocto/defconfig
```

Set
```
CONFIG_BLK_DEV_NVME=m
```

Get the
```
modules--..........tar.gz
```
under
```
intel_aero/poky/build/tmp/deploy/images/intel-aero
```

and extract nvme.ko
