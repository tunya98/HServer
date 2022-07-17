#!/bin/bash
echo 欢迎使用HServer!
echo 3秒后启动
sleep 3
apt install nano
if [ -e ${HOME}/mc ]
then
MENU=$(whiptail --title "菜单" --menu "你想对这个小可爱做什么呢?" 0 50 0 \
"1" "启动服务器" \
"2" "配置服务器" \
3>&1 1>&2 2>&3)
case ${MENU} in
1)
cd ${HOME}/mc
LD_PRELOAD= ./bedrock_server
;;
2)
cd mc && nano server.properties
;;
esac
fi
esac
else
OPTION=$(whiptail --title "server version" --menu "请选择你要安装的服务器版本" 15 60 4 \
"1" "1.19.10.03"  
3>&1 1>&2 2>&3)
case ${OPTION} in
1)VER="1.19.10.03";;
esac
exitstatus=$?
if [ $exitstatus = 0 ]; then
    echo "Your favorite programming language is:" $OPTION
    aria2c --console-log-level=warn --no-conf -d "${HOME}/mc/" --allow-overwrite=true -o "mc.zip" "https://minecraft.azureedge.net/bin-linux/bedrock-server-${VER}.zip"
else
    echo "You chose Cancel."
fi
echo -e "${green}正在解压${none}"
unzip -q -d ${HOME}/mc/ ${HOME}/mc/mc.zip
rm ${HOME}/mc/mc.zip
chmod +x ${HOME}/mc/bedrock_server
sh ${HOME}/mc/bedrock_server
fi
