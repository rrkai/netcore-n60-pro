#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default

# ===== 新增：PassWall 源 =====
echo 'src-git passwall https://github.com/Openwrt-Passwall/openwrt-passwall.git;main' >>feeds.conf.default
echo 'src-git passwall_packages https://github.com/Openwrt-Passwall/openwrt-passwall-packages.git;main' >>feeds.conf.default
# echo 'src-git passwall2 https://github.com/Openwrt-Passwall/openwrt-passwall2.git;main' >>feeds.conf.default

# ===== 移除：AdGuardHome 源（原来有 git clone，现在删掉） =====
# git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
# chmod -R 755 ./package/luci-app-adguardhome/*
