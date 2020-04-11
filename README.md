# dvbheadend Raspberry Pi 3 firmware for USB DVB tuners and tvheadend

This is a [Raspberry Pi](https://www.raspberrypi.org/products/) firmware image for running [Tvheadend](https://tvheadend.org/) on a local network in the most reliable way possible.

## Using

* Create SD card using `sdcard.img`.
* Plug in SD card DVB USB tuner(s) and wired ethernet.
* Browse to <http://dvbheadend.local/> to configure tvheadend.

Tvheadend uses HTTP port 80 and HTSP port 9982. It works perfectly with Kodi / [LibreELEC](https://libreelec.tv/) mediacentre on a Raspberry Pi 3 with [MPEG-2 license key](https://codecs.raspberrypi.org/mpeg-2-license-key/).

## Supported hardware

* [Raspberry Pi 3](https://www.raspberrypi.org/products/raspberry-pi-3-model-b-plus/)
* [Linux supported DVB USB device(s)](https://www.linuxtv.org/wiki/index.php/Hardware_device_information)
* Minimum 1GB SD card. Remaining space on the SD card is used for tvheadend configuration and recordings.

Adding support for other models/boards [supported by buildroot](https://github.com/buildroot/buildroot/tree/master/board) is possible.

## Building

```bash
cd ..
git clone git://git.buildroot.net/buildroot
make O=$PWD/dvbheadend_build BR2_EXTERNAL=../dvbheadend -C buildroot dvbheadend_raspberrypi3_defconfig
make
```

## Installing

Create SD card from image in `output/images/sdcard.img`.

## Updating

Use `output/images/Image` to replace the `Image` file on the SD card (or scp to `/boot/`) and reboot.

## Network

Network is auto configured, DNS-SD/Bonjour autodiscovery is supported. Additionally to IPv6, the device fully supports legacy IP. NTP server and time zone can be set using DHCP.

### Monitoring

[node_exporter](https://github.com/prometheus/node_exporter) for [Prometheus](https://prometheus.io/) is running on <http://dvbheadend.local:9100/metrics>.

## Access

The firmware is running a buildroot Linux rootfs built using [systemd](https://www.freedesktop.org/wiki/Software/systemd/) and [busybox](https://busybox.net/). All changes except on the `/boot` and `/home/tvheadend` mountpoints are lost on reboot.

### Console

Password for root is empty.

### SSH

Keys only. Put an `authorized_keys` file on the FAT parition, reboot.

```bash
ssh root@dvbheadend.local
```
