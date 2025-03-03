# Copyright (C) 2016 Openwrt.org
#
# This is free software, licensed under the Apache License, Version 2.0 .
#

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-timedreboot
PKG_VERSION:=1.1
PKG_RELEASE:=1

PKG_MAINTAINER:=pmkol <pmkol@foxmail.com>

LUCI_TITLE:=LuCI Application to timing reboot
LUCI_DEPENDS:=+luci +bash
LUCI_PKGARCH:=all

include $(TOPDIR)/feeds/luci/luci.mk

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/config
	cp ./root/etc/config/timedreboot $(1)/etc/config/timedreboot

	$(INSTALL_DIR) $(1)/etc/init.d
	cp ./root/etc/init.d/timedreboot $(1)/etc/init.d/timedreboot

	$(INSTALL_DIR) $(1)/usr
	cp -pR ./root/usr/* $(1)/usr/

	$(INSTALL_DIR) $(1)/usr/lib/lua/luci
	cp -pR ./luasrc/* $(1)/usr/lib/lua/luci/
endef

define Package/$(PKG_NAME)/postinst
#!/bin/sh
    chmod a+x ${IPKG_INSTROOT}/etc/init.d/timedreboot >/dev/null 2>&1
    chmod a+x ${IPKG_INSTROOT}/usr/bin/dorboot >/dev/null 2>&1
    exit 0
endef

define Package/$(PKG_NAME)/postrm
#!/bin/sh
    sed -i '/dorboot/d' /etc/crontabs/root >/dev/null 2>&1 || echo ""
    rm -rf /tmp/luci-modulecache/ >/dev/null 2>&1 || echo ""
    rm -f /tmp/luci-indexcache >/dev/null 2>&1 || echo ""
    exit 0
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
