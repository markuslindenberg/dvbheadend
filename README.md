# dvbheadend Raspberry Pi 3 firmware for DVB-T headends w/ tvheadend

## Building

```
cd ..
git clone git://git.buildroot.net/buildroot
make O=$PWD/dvbheadend_build BR2_EXTERNAL=../dvbheadend -C buildroot dvbheadend_raspberrypi3_64_defconfig
make
```

## Installing

Create SD card from image in `output/images/sdcard.img`.

## Updating

Use `output/images/Image` to replace the `Image` file on the SD card (mounted as `/boot/`) and reboot.

## Network

DHCP and link-local addressing. 

## Access

### Console

Password for root is empty.

### SSH

Keys only. Put an `authorized_keys` file on the SD card, reboot.

```bash
ssh root@dvbheadend.local
```

