################################################################################
#
# node_exporter
#
################################################################################

NODE_EXPORTER_VERSION = 0.18.1
NODE_EXPORTER_SITE = $(call github,prometheus,node_exporter,v$(NODE_EXPORTER_VERSION))
NODE_EXPORTER_LICENSE = Apache-2.0
NODE_EXPORTER_LICENSE_FILES = LICENSE

define NODE_EXPORTER_INSTALL_INIT_SYSTEMD
	$(INSTALL) -D -m 644 $(NODE_EXPORTER_PKGDIR)/node_exporter.service \
		$(TARGET_DIR)/usr/lib/systemd/system/node_exporter.service
	mkdir -p $(TARGET_DIR)/usr/lib/systemd/system/multi-user.target.wants
	ln -sf ../../../../usr/lib/systemd/system/node_exporter.service \
		$(TARGET_DIR)/usr/lib/systemd/system/multi-user.target.wants/node_exporter.service
endef

$(eval $(golang-package))
