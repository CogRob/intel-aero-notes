# How to install ROS on Intel Aero's Yocto

  + Yocto is an embedded operating system based on linux. 
  + You don't install yocto on the Intel board and then install ROS on it.
  + Instead you build a Yocto OS image that already contains installed yocto. 
  + There are conflicting information in openembedded and yoctoproject. Follow
    yoctoproject when in doubt. Although yocto project does not contain meta-ros
    as a recipe. Then switch back to openembedded instructions.
  + The instructions are simple. We want to build a yocto recipe, with
    meta-intel-aero `bitbake intel-aero-image`
  + Before you build intel-aero-image, add roslaunch as IMAGE_INSTALL += dependency
    in the https://github.com/intel-aero/meta-intel-aero/blob/master/recipes-core/images/intel-aero-image.bb
    file.

## Instructions 
  + A pre-compiled image with NVME enabled is available here: (pcloud)[https://my.pcloud.com/publink/show?code=XZeJBU7ZbTRFkJYTQYf6dkozhilX10ssCfvk]
  + https://github.com/intel-aero/meta-intel-aero/wiki/96-(References)-Rebuild-Yocto
  + Checkout all the repositories to desired yocto version say `origin/pyro`

        $ for d in meta*;do cd $d && git checkout origin/pyro; cd -; done

  + Prepare environment
  
        $ cd openembedded.org
        $ docker-compose run terminal
    
  + Checkout repositories. Use 1.6.2.xml instead of 1.6.xml
  
       $ cd ../intel_aero_1.6.2
       $ repo init -u https://github.com/intel-aero/intel-aero-manifest.git -m v1.6.2.xml -b master
       $ repo sync -j4
       
   + Initialize the environment
   
       $ cd poky
       $ export TEMPLATECONF=../meta-intel-aero/conf/
       $ source oe-init-build-env

   + Try applying patches 
   
       $ for p in *.patch; do cd ${p/.patch/} && { patch -u1 < $p; cd -; }; done

   + Enable CONFIG_BLK_DEV_NVME=m as a kernel module
   
      ```
      vdhiman@8c8f2c1f54d6:~/.../poky/build$ grep -R 'NVME' ../../meta-intel-aero-base/recipes-kernel/
      ../../meta-intel-aero-base/recipes-kernel/linux/linux-yocto/defconfig:CONFIG_BLK_DEV_NVME=m

      ```
      
   + Compile from `intel_aero/poky/build`
   
       $ bitbake intel-aero-image
   
   + Look for the image in `intel_aero/poky/build/tmp/deploy/images/intel-aero/`


## Instructions for compiling NVMe kernel module
   + Follow instructions here:
   https://github.com/intel-aero/packages
   - Change patches/defconfig to enable NVME
   - Change patches-4.4/defconfig to enable NVME
    - make kernel-source
    - make kernel-patch
    - make kernel
   - Look for resultant files in aero-kernel/*.deb
   + Download kernel source
   
       $ wget https://mirrors.edge.kernel.org/pub/linux/kernel/v4.x/linux-4.4.76.tar.gz
       $ tar xf linux-4.4.76.tar.gz
       
   + Download `meta-intel-aero-base` kernel config
   
       $ wget https://raw.githubusercontent.com/intel-aero/meta-intel-aero-base/master/recipes-kernel/linux/linux-yocto/defconfig
       $ cd linux-4.4.760
       $ make menucurses
       
   + Make sure that Device Drivers -> NVM Express block device is marked as module <M>
