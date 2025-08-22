#!/bin/bash -e

# backup feeds
shopt -s extglob
mkdir -p /tmp/lite/
mv */ /tmp/lite/

# download feeds
git clone https://github.com/immortalwrt/luci immortalwrt/luci -b master --depth 1
git clone https://github.com/immortalwrt/packages immortalwrt/packages -b master --depth 1
git clone https://github.com/immortalwrt/homeproxy immortalwrt/luci-app-homeproxy --depth 1
git clone https://github.com/sbwml/openwrt_helloworld --depth 1
git clone https://github.com/pmkol/openwrt-mihomo --depth 1
git clone https://github.com/pmkol/v2ray-geodata --depth 1
rm -rf immortalwrt/luci-app-homeproxy/{.git,.github,LICENSE,README}
rm -rf openwrt_helloworld/{luci-app-homeproxy,luci-app-nikki,nikki,v2ray-geodata}
rm -rf v2ray-geodata/.git

# helloworld
mv openwrt_helloworld/*/ ./
rm -rf openwrt_helloworld

# luci-app-dae
mv immortalwrt/luci/applications/luci-app-dae ./
sed -i 's|../../luci.mk|$(TOPDIR)/feeds/luci/luci.mk|' luci-app-dae/Makefile
mv immortalwrt/packages/net/dae ./
sed -i 's|../../lang|$(TOPDIR)/feeds/packages/lang|' dae/Makefile

# luci-app-homeproxy
mv immortalwrt/luci-app-homeproxy ./

# luci-app-mihomo
mv openwrt-mihomo/*/ ./
rm -rf openwrt-mihomo

# haproxy
mv immortalwrt/packages/net/haproxy ./
sed -i 's/lua5.4/lua5.3/g' haproxy/Makefile

curl -s https://mirror.apad.pro/sources/fix-lite.sh | bash
rm -rf immortalwrt
ls -d */ | xargs -n 1 basename | paste -sd ' ' - > packages.txt
