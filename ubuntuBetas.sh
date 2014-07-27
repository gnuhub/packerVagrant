#!/bin/bash

version="14.10"
cpu="amd64"
codename="utopic"
edition="desktop"
isoSrc="${codename}-${edition}-${cpu}.iso"
iso="ubuntu-${version}-${edition}-${cpu}.iso"
destDir="/home/dennis/gits/packerVagrant/packer/iso/"
confDir="/home/dennis/gits/packerVagrant/packer/configs/"
conf="ubuntu-${version}-Desktop-${cpu}.json"
url="http://cdimage.ubuntu.com/daily-live/current/"

if [ ! -e "${destDir}${iso}" ]; then
	wget "${url}${isoSrc}" -O "${destDir}${iso}"
	echo "No iso found"
elif [ `find ${destDir} -name "${iso}" -mtime +1` ]; then
	wget "${url}${isoSrc}" -O "${destDir}${iso}"
	echo "ISO found, but out of date"
else
	echo "Latest build found"
fi

mv "${destDir}${iso}" "${destDir}${iso}"

cd "${confDir}"

packer build "${conf}"
