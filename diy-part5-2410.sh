#!/bin/bash
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part5-2410.sh
# Description: OpenWrt DIY script part 5 (After Update feeds)
#
# Copyright (c) 2019-2024 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate

# Modify default theme
#sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile

# Modify hostname
#sed -i 's/OpenWrt/P3TERX-Router/g' package/base-files/files/bin/config_generate

# 移除USB网络共享
sed -i 's/kmod-usb-net-rndis //g' target/linux/mediatek/image/mt7986.mk

# 添加组播防火墙规则
cat >> package/network/config/firewall/files/firewall.config <<EOF
config rule
        option name 'Allow-UDP-igmpproxy'
        option src 'wan'
        option dest 'lan'
        option dest_ip '224.0.0.0/4'
        option proto 'udp'
        option target 'ACCEPT'        
        option family 'ipv4'

config rule
        option name 'Allow-UDP-udpxy'
        option src 'wan'
        option dest_ip '224.0.0.0/4'
        option proto 'udp'
        option target 'ACCEPT'
EOF
# ===== 修改主机名为 WaterOS =====
sed -i "s/hostname='ImmortalWrt'/hostname='WaterOS'/" package/base-files/files/bin/config_generate

# ===== 设置 root 密码为 www666 =====
# 方法1：生成密码哈希并写入 shadow 文件
# 需要先生成 md5crypt 哈希：openssl passwd -1 "www666"
# 假设生成的哈希为：$1$xyz$abc...（实际使用时替换）
# 这里提供一个示例结构，实际编译前需要生成真实哈希

# 临时方案：设置空密码，首次启动后通过 LuCI 设置
# 如需预设密码，请取消下面注释并替换哈希值
# sed -i 's|^root::0:99999:7:::|root:$1$V4UetPzk$CYXluq4wUazHJoCnh7MYEH.:0:99999:7:::|' package/base-files/files/etc/shadow

# 更简单的方法：添加一个初始化脚本，首次启动时设置密码
cat > package/base-files/files/etc/uci-defaults/99-set-password <<'EOF'
#!/bin/sh
# 首次启动时执行，设置 root 密码为 www666
echo "root:www666" | chpasswd
# 删除自身，只执行一次
rm -f /etc/uci-defaults/99-set-password
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-set-password
