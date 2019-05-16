```
fdisk /dev/nvme0n1
g
p - default - default - default ...
w
```

```
mkfs -t ext4 /dev/nvme0n1p1
mkdir /mnt/nvme
```

```
blkid
vi /etc/fstab

Add the following line
UUID=nvme_UUID /media/nvme ext4 defaults 0 0
```

# Docker
```
mkdir -p /mnt/nvme/docker
```

Add to `/etc/docker/daemon.json`
```
{
  "graph": "/mnt/nvme/docker"
}
```

# Root

```
mkdir -p /mnt/nvme/root
```

Change `/etc/passwd`
