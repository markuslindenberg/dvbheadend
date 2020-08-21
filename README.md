![image](https://github.com/markuslindenberg/dvbheadend/workflows/image/badge.svg)

# Introduction

This is a [Raspberry Pi 4](https://www.raspberrypi.org/products/) firmware image for running [Tvheadend](https://tvheadend.org/) on a local network in the most reliable way possible.

# Installation

## Supported hardware

* [Raspberry Pi](https://www.raspberrypi.org/products/) 4.
* [Linux supported DVB USB device(s)](https://www.linuxtv.org/wiki/index.php/Hardware_device_information)
* Minimum 1GB SD card. Remaining space on the SD card is used for tvheadend configuration and recordings.

Adding support for other models/boards [supported by buildroot](https://github.com/buildroot/buildroot/tree/master/board) is possible.

## Download

Releases are not yet available on the [releases](https://github.com/markuslindenberg/dvbheadend/releases) page.

Currently, SD card images are built automatically and can be downloaded from the latest [successful Github Actions run](https://github.com/markuslindenberg/dvbheadend/actions?query=is%3Asuccess+workflow%3Aimage).

## Setup

* Write `sdcard.img` on an empty SD card.
* Plug in SD card DVB USB tuner(s) and wired ethernet.
* Browse to <http://dvbheadend.local/> to configure tvheadend.

Tvheadend uses HTTP port 80 and HTSP port 9982. It works perfectly with Kodi / [LibreELEC](https://libreelec.tv/) mediacentre on a Raspberry Pi 3 with [MPEG-2 license key](https://codecs.raspberrypi.org/mpeg-2-license-key/).

# Operation

The firmware is running a Linux initramfs in RAM as root filesystem. All changes except on the `/boot` and `/home/tvheadend` partitions are lost on reboot.

## Updating

Instead of re-flashing the SD card you can just replace the `Image` file on the SD card (or scp to `/boot/`) and reboot.

## Network

DHCP / auto configuration and link local addressing are enabled. Additionally to IPv6, the device fully supports legacy IP. NTP server can be set using DHCP, otherwise pool.ntp.org will be used.

### Accessible ports

| Port | Process        |
| ---- | -------------- |
| 22   | SSH            |
| 80   | tvheadend HTTP |
| 9982 | tvheadend HTSP |
| 9100 | node_exporter  |

### Discovery

LLMNR and DNS-SD/Bonjour will announce <http://dvbheadend.local/>.

## Monitoring

[node_exporter](https://github.com/prometheus/node_exporter) for [Prometheus](https://prometheus.io/) is running on <http://dvbheadend.local:9100/metrics>.

## Access

### Console

Use a serial console at 115200 or keyboard & monitor to access the console. Password for root is empty.

### SSH

Keys only. Put an `authorized_keys` file on the FAT partition, reboot.

```bash
ssh root@dvbheadend.local
```

# Development

This repository is a Buildroot br2-external tree, see the [Buildroot manual](https://buildroot.org/downloads/manual/manual.html#outside-br-custom) for build instructions.
