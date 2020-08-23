################################################################################
#
# armbian-firmware-external
#
################################################################################

ARMBIAN_FIRMWARE_EXTERNAL_VERSION = b14e28319cbe87b006fb0259bc0143eeaf5b2409
ARMBIAN_FIRMWARE_EXTERNAL_SITE = https://github.com/armbian/firmware
ARMBIAN_FIRMWARE_EXTERNAL_SITE_METHOD = git

# XR819 WiFi firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_EXTERNAL_XR819),y)
ARMBIAN_FIRMWARE_EXTERNAL_FILES += \
	xr819/boot_xr819.bin \
	xr819/fw_xr819.bin \
	xr819/sdd_xr819.bin
endif

# AP6212 WiFi/BT combo firmware
ifeq ($(BR2_PACKAGE_ARMBIAN_FIRMWARE_EXTERNAL_AP6212),y)
ARMBIAN_FIRMWARE_EXTERNAL_DIRS += ap6212
endif

ifneq ($(ARMBIAN_FIRMWARE_EXTERNAL_FILES),)
define ARMBIAN_FIRMWARE_EXTERNAL_INSTALL_FILES
	cd $(@D) && \
		$(TAR) cf install.tar $(sort $(ARMBIAN_FIRMWARE_EXTERNAL_FILES)) && \
		$(TAR) xf install.tar -C $(TARGET_DIR)/lib/firmware
endef
endif

ifneq ($(ARMBIAN_FIRMWARE_EXTERNAL_DIRS),)
# We need to rm -rf the destination directory to avoid copying
# into it in itself, should we re-install the package.
define ARMBIAN_FIRMWARE_EXTERNAL_INSTALL_DIRS
	$(foreach d,$(ARMBIAN_FIRMWARE_EXTERNAL_DIRS), \
		rm -rf $(TARGET_DIR)/lib/firmware/$(d); \
		cp -a $(@D)/$(d) $(TARGET_DIR)/lib/firmware/$(d)$(sep))
endef
endif

ifneq ($(ARMBIAN_FIRMWARE_EXTERNAL_FILES)$(ARMBIAN_FIRMWARE_EXTERNAL_DIRS),)
ARMBIAN_FIRMWARE_EXTERNAL_LICENSE = PROPRIETARY
ARMBIAN_FIRMWARE_EXTERNAL_REDISTRIBUTE = NO
endif

define ARMBIAN_FIRMWARE_EXTERNAL_INSTALL_TARGET_CMDS
	mkdir -p $(TARGET_DIR)/lib/firmware
	$(ARMBIAN_FIRMWARE_EXTERNAL_INSTALL_FILES)
	$(ARMBIAN_FIRMWARE_EXTERNAL_INSTALL_DIRS)
endef

$(eval $(generic-package))
