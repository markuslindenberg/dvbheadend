################################################################################
#
# mn88472-firmware
#
################################################################################

MN88472_FIRMWARE_VERSION = 1.0
MN88472_FIRMWARE_SOURCE = dvb-demod-mn88472-02.fw
MN88472_FIRMWARE_SITE = http://palosaari.fi/linux/v4l-dvb/firmware/MN88472/02/latest

define MN88472_FIRMWARE_EXTRACT_CMDS
endef

define MN88472_FIRMWARE_INSTALL_TARGET_CMDS
	$(INSTALL) -m 0644 -D -t $(TARGET_DIR)/usr/lib/firmware $(MN88472_FIRMWARE_DL_DIR)/$(MN88472_FIRMWARE_SOURCE)
endef

$(eval $(generic-package))
