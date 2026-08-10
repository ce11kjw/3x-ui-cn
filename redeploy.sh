#!/bin/bash
red="\033[0;31m"
green="\033[0;32m"
yellow="\033[0;33m"
plain="\033[0m"
echo -e "${green}3X-UI 中文版 一键重新部署${plain}"
[[ $EUID -ne 0 ]] && echo -e "${red}错误：请使用root权限${plain}" && exit 1
echo -e "${yellow}[1/4] 停止旧服务...${plain}"
systemctl stop x-ui 2>/dev/null; systemctl disable x-ui 2>/dev/null; pkill -f x-ui 2>/dev/null
echo -e "${green}  done${plain}"
echo -e "${yellow}[2/4] 卸载旧版...${plain}"
rm -rf /usr/local/x-ui; rm -f /usr/bin/x-ui; rm -f /etc/systemd/system/x-ui.service; systemctl daemon-reload 2>/dev/null
echo -e "${green}  done${plain}"
echo -e "${yellow}[3/4] 安装中文版...${plain}"
bash <(curl -Ls https://raw.githubusercontent.com/ce11kjw/3x-ui-cn/main/install.sh)
echo -e "${yellow}[4/4] 替换管理菜单为中文版...${plain}"
curl -sL https://raw.githubusercontent.com/ce11kjw/3x-ui-cn/main/x-ui.sh -o /usr/bin/x-ui && chmod +x /usr/bin/x-ui
echo -e "${green}  done${plain}"
echo -e "${green}✅ 重新部署完成！输入 x-ui 打开中文管理菜单${plain}"
