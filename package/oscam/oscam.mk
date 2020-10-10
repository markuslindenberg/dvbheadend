################################################################################
#
# oscam
#
################################################################################

OSCAM_VERSION = 11650
OSCAM_SITE = https://svn.streamboard.tv/oscam/trunk
OSCAM_SITE_METHOD = svn
OSCAM_DEPENDENCIES = openssl

define OSCAM_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(OSCAM_PKGDIR)/oscam.service \
		$(TARGET_DIR)/usr/lib/systemd/system/oscam.service
	mkdir -p $(TARGET_DIR)/usr/lib/systemd/system/multi-user.target.wants
	ln -sf ../../../../usr/lib/systemd/system/oscam.service \
		$(TARGET_DIR)/usr/lib/systemd/system/multi-user.target.wants/oscam.service
endef

$(eval $(cmake-package))
