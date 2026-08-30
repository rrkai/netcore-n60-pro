#!/bin/bash

# ===== 修改主机名（237 源码默认是 ImmortalWrt，不是 OpenWrt）=====
sed -i "s/hostname='ImmortalWrt'/hostname='TKubeOS'/" package/base-files/files/bin/config_generate

# ===== 修改默认 SSID =====
sed -i 's/ssid="ImmortalWrt-2.4G"/ssid="TKubeOS-2.4G"/' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh
sed -i 's/ssid="ImmortalWrt-5G"/ssid="TKubeOS-5G"/' package/mtk/applications/mtwifi-cfg/files/mtwifi.sh

# ===== 替换 SSH 登录横幅为 TKubeOS（%D %V %C 由编译系统自动替换为版本信息）=====
cat > package/base-files/files/etc/banner <<'EOF'
████████╗██╗  ██╗██╗   ██╗██████╗ ███████╗ ██████╗ ███████╗
╚══██╔══╝██║ ██╔╝██║   ██║██╔══██╗██╔════╝██╔═══██╗██╔════╝
   ██║   █████╔╝ ██║   ██║██████╔╝█████╗  ██║   ██║███████╗
   ██║   ██╔═██╗ ██║   ██║██╔══██╗██╔══╝  ██║   ██║╚════██║
   ██║   ██║  ██╗╚██████╔╝██████╔╝███████╗╚██████╔╝███████║
   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚═════╝ ╚══════╝ ╚═════╝ ╚══════╝
 ---------------------------------------------------------------
 TKubeOS · Custom firmware for Netcore N60 PRO
 %D %V, %C
 ---------------------------------------------------------------
EOF

# ===== 预设 root 密码（首次启动执行后自动删除脚本）=====
cat > package/base-files/files/etc/uci-defaults/99-set-password <<'EOF'
#!/bin/sh
echo "root:www666" | chpasswd
rm -f /etc/uci-defaults/99-set-password
EOF
chmod +x package/base-files/files/etc/uci-defaults/99-set-password
