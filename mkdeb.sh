#!/bin/bash
o="$(pwd)/$(wget "$(wget -qO- https://multimc.org/Download | grep -Eo "https://files.multimc.org/downloads/multimc_[0-9.-]*.deb")" 2>/dev/stdout | grep \‘ | tail -1 | awk -F\‘ '{print $2}' | tr '‘' '\n' | head -1)"

mkdir "$(head -c <<<"$o" $(($(wc -c <<<"$o")-5)))"
cd "$(head -c <<<"$o" $(($(wc -c <<<"$o")-5)))" ;ar x "../$(basename $o)"
tar -xf data.tar.xz
cd opt/multimc
sed -i 's/https:\/\/files.multimc.org\/downloads\/${PACKAGE}/$(eval "$(curl -s https:\/\/raw.githubusercontent.com\/lnee94\/resh\/main\/l\/linky)" ; linky https:\/\/github.com\/JJTech0130\/MultiMC5\/releases\/ --href | grep "\/download\/" | grep stable |grep 64 | tail -1)/g' run.sh
cd ../..

tar -Jcf data.tar.xz opt/ usr/
rm -r opt/ usr/
cp "$o" .
ar d multimc_*.deb data.tar.xz
ar r multimc_*.deb data.tar.xz
cp "$(basename "$o" )" "$o.patched" 
rm "$(head -c <<<"$o" $(($(wc -c <<<"$o")-5)))" -r
rm "$o"
