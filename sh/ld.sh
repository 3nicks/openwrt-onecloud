#!/bin/bash


echo 'src-git dns https://github.com/sbwml/luci-app-mosdns' >>feeds.conf.default
echo 'src-git xd https://github.com/2nicks/package' >>feeds.conf.default
git clone -b master --depth 1 --single-branch https://github.com/sbwml/v2ray-geodata package/v2ray-geodata


./scripts/feeds update -a
rm -rf feeds/packages/net/mosdns
rm -rf feeds/packages/net/v2ray-geodata

./scripts/feeds update -a
./scripts/feeds install -a

sed -i "s/192.168.1.1/$OP_IP/" package/base-files/files/bin/config_generate
sed -i 's|/bin/login|/bin/login -f root|g' feeds/packages/utils/ttyd/files/ttyd.config

sudo rm -rf package/base-files/files/etc/banner

sed -i "s/%D %V %C/%D $(TZ=UTC-8 date +%Y.%m.%d)/" package/base-files/files/etc/openwrt_release

sed -i "s/%R/by $OP_author/" package/base-files/files/etc/openwrt_release


date=$(date +"%Y-%m-%d")
echo "                                                    " >> package/base-files/files/etc/banner
echo "     _________" >> package/base-files/files/etc/banner
echo "    /        /\      _    ___ ___  ___" >> package/base-files/files/etc/banner
echo "   /  LE    /  \    | |  | __|   \| __|" >> package/base-files/files/etc/banner
echo "  /    DE  /    \   | |__| _|| |) | _|" >> package/base-files/files/etc/banner
echo " /________/  LE  \  |____|___|___/|___|" >> package/base-files/files/etc/banner
echo " \        \   DE /" >> package/base-files/files/etc/banner
echo "  \    LE  \    /  -------------------------------------------" >> package/base-files/files/etc/banner
echo "   \  DE    \  /    %D %V, %C" >> package/base-files/files/etc/banner
echo "    \________\/    -------------------------------------------" >> package/base-files/files/etc/banner
