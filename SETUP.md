# 1️⃣ Format & mount the second drive (host)

On Linux, ext4 is ideal. Time Machine does NOT require APFS on the server side.

## Identify the disk
Look for sdX identifier (e.g. sda, sdb)
``` bash
lsblk
```

## Format (⚠️ wipes the disk)
``` bash
sudo mkfs.ext4 /dev/sdX
```

## Create mount point
``` bash
sudo mkdir -p /mnt/timemachine
```

## Mount it
``` bash
sudo mount /dev/sdX /mnt/timemachine
```

## Persist across reboots (important)
``` bash
sudo blkid /dev/sdX
```

Copy UUID from return
``` bash
UUID=xxxx-xxxx  /mnt/timemachine  ext4  defaults,noatime  0  2
```

## Edit /etc/fstab
Open it with:
``` bash
sudo nano /etc/fstab
```
Add this line below your existing entries.
⚠️ Spacing matters, but tabs or spaces are both fine.
```
UUID=xxxx-xxxx  /mnt/timemachine  ext4  defaults,noatime,  0  2
```
Save and exit:
* Ctrl + O
* Enter
* Ctrl + X

## Test
``` bash
sudo mount -a
```

# 2️⃣ Prepare directories & permissions

``` bash
sudo mkdir -p /mnt/timemachine/backups
sudo chown -R 1000:1000 /mnt/timemachine
sudo chmod 700 /mnt/timemachine/backups
```
UID 1000 is the default Linux user — matches Docker nicely.

## Firewall check (only if UFW is enabled)
``` bash
sudo ufw status
```
If active:
``` bash
sudo ufw allow 5353/udp
sudo ufw allow 445/tcp
```

# Step 3: Setup Dockerfile

Using `mbentley/timemachine`
* Correct SMB fruit extensions
* Advertises as Time Machine disk
* Works with Ventura, Sonoma, Sequoia
* Zero manual Samba config