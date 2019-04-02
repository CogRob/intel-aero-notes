# EFI Notes

## rEFInd bootloader
rEFInd vs GRUB
https://askubuntu.com/questions/760875/any-downside-to-using-refind-instead-of-grub

+ rEFInd scans for kernel on every boot, hence better for recovery

## How to add NVME driver on rEFInd bootloader

+ Install [rEFInd](https://www.rodsbooks.com/refind/installing.html)

+ You can use EFI shell to configure how EFI boots. Even if you install rEFInd
  through some other method, see manual install instructions to understand EFI
  Shell capabilities
  [here](https://www.rodsbooks.com/refind/installing.html#efishell).
  
+ Get nvme driver
    * The nvme driver is committed to this repository but was extract using following steps:
    `nvmexpressdxe-64.efi`
  
    * Download latest Clover bootable ISO: https://sourceforge.net/projects/cloverefiboot/files/Bootable_ISO/
    `wget https://astuteinternet.dl.sourceforge.net/project/cloverefiboot/Bootable_ISO/CloverISO-4910.tar.lzma`
    * Extract ISO `unlma CloverISO*.lzma`, `tar xvf CloverISO*.tar`
    * Mount ISO `sudo mount -t iso9660 -o loop CloverISO*.iso /tmp/clover/`
    * Find nvme driver `find /tmp/clover/ -iname '*nvme*.efi'`


+ Put `nvmexpressdxe-64.efi` in the `<rEFInd installation folder>/drivers_x64/`. 
  Default rEFInd installation is `/boot/EFI/refind/`.
  Default driver folder should be `/boot/EFI/refind/drivers_x64/`
