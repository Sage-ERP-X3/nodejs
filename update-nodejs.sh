#!/bin/sh
# Currently the remote branch MUST exist
# Sample usage: update-nodejs.sh 4.4.4 0.12.14
git fetch origin
git checkout $1
cd win32_x64
curl -O https://raw.githubusercontent.com/nodejs/node/master/LICENSE
curl -O https://nodejs.org/dist/v$1/win-x64/node.exe

cd ../linux_x64
curl -O https://nodejs.org/dist/v$1/node-v$1-linux-x64.tar.gz
tar -xvf node-v$1-linux-x64.tar.gz node-v$1-linux-x64/LICENSE
tar -xvf node-v$1-linux-x64.tar.gz node-v$1-linux-x64/bin/node
mv node-v$1-linux-x64/LICENSE LICENSE
mv node-v$1-linux-x64/bin/node node
rm -r node-v$1-linux-x64
rm node-v$1-linux-x64.tar.gz

if [ -n "$2" ]; then
	cd el6	
	curl -O https://nodejs.org/dist/v$2/node-v$2-linux-x64.tar.gz
	tar -xvf node-v$2-linux-x64.tar.gz node-v$2-linux-x64/LICENSE
	tar -xvf node-v$2-linux-x64.tar.gz node-v$2-linux-x64/bin/node
	mv node-v$2-linux-x64/LICENSE LICENSE
	mv node-v$2-linux-x64/bin/node node
	rm -r node-v$2-linux-x64
	rm node-v$2-linux-x64.tar.gz
	cd ..
fi

cd ../darwin_x64
curl -O https://nodejs.org/dist/v$1/node-v$1-darwin-x64.tar.gz
tar -xvf node-v$1-darwin-x64.tar.gz node-v$1-darwin-x64/LICENSE
tar -xvf node-v$1-darwin-x64.tar.gz node-v$1-darwin-x64/bin/node
mv node-v$1-darwin-x64/LICENSE LICENSE
mv node-v$1-darwin-x64/bin/node node
rm -r node-v$1-darwin-x64
rm node-v$1-darwin-x64.tar.gz
cd ..

