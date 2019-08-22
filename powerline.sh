#!/bin/bash

FILE_BASHRC="/etc/bash.bashrc"
URL="https://github.com/eosrei/twemoji-color-font/releases/download/v11.2.0/TwitterColorEmoji-SVGinOT-Linux-11.2.0.tar.gz"
FONT_FILE=$(basename -- "${URL}")
FONT_DIR="${FONT_FILE%.*}"
FONT_DIR="${FONT_DIR%.*}"

apt-get update
apt-get install -y python-pip fonts-powerline ttf-bitstream-vera
pip install powerline-status powerline-gitstatus powerline-docker netifaces
cd ~ && wget "${URL}" && tar zxvf "${FONT_FILE}"
cp "${FONT_DIR}"/TwitterColorEmoji-SVGinOT.ttf /usr/share/fonts/truetype/ttf-bitstream-vera/Vera
rm "${FONT_FILE}"
rm -rf "${FONT_DIR}"

grep -q "POWERLINE" "${FILE_BASHRC}"
if [ $? != 0 ] ; then
cat << EOF >> "${FILE_BASHRC}"
if [ -f $(which powerline-daemon) ]; then
    powerline-daemon -q
	POWERLINE_BASH_CONTINUATION=1
	POWERLINE_BASH_SELECT=1
fi
if [ -f /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh ]; then
    source /usr/local/lib/python2.7/dist-packages/powerline/bindings/bash/powerline.sh
fi
EOF
fi
