#!/bin/sh
# Currently the remote branch MUST exist
# Sample usage: update-nodejs.sh 4.4.4 0.12.14
git fetch origin
git checkout $1

cd win32_x64
echo "=== update windows version to $1"
echo GET https://nodejs.org/dist/v$1/win-x64/node.exe in `pwd`
curl -O https://raw.githubusercontent.com/nodejs/node/master/LICENSE
curl -O https://nodejs.org/dist/v$1/win-x64/node.exe

cd ../linux_x64
echo "=== update linux version to $1"
echo GET https://nodejs.org/dist/v$1/node-v$1-linux-x64.tar.gz in `pwd`
curl -O https://nodejs.org/dist/v$1/node-v$1-linux-x64.tar.gz
tar -xvf node-v$1-linux-x64.tar.gz node-v$1-linux-x64/LICENSE
tar -xvf node-v$1-linux-x64.tar.gz node-v$1-linux-x64/bin/node
mv node-v$1-linux-x64/LICENSE LICENSE
mv node-v$1-linux-x64/bin/node node
rm -r node-v$1-linux-x64
rm node-v$1-linux-x64.tar.gz

cd ../darwin_x64
echo "=== update mac version to $1"
echo GET https://nodejs.org/dist/v$1/node-v$1-darwin-x64.tar.gz in `pwd`
curl -O https://nodejs.org/dist/v$1/node-v$1-darwin-x64.tar.gz
tar -xvf node-v$1-darwin-x64.tar.gz node-v$1-darwin-x64/LICENSE
tar -xvf node-v$1-darwin-x64.tar.gz node-v$1-darwin-x64/bin/node
mv node-v$1-darwin-x64/LICENSE LICENSE
mv node-v$1-darwin-x64/bin/node node
rm -r node-v$1-darwin-x64
rm node-v$1-darwin-x64.tar.gz
cd ..

if [ -n "$2" ]; then
	cd linux_x64/el6	
	echo "=== update linux el6 version to $2"
	echo GET https://nodejs.org/dist/v$2/node-v$2-linux-x64.tar.gz in `pwd`
	curl -O https://nodejs.org/dist/v$2/node-v$2-linux-x64.tar.gz
	tar -xvf node-v$2-linux-x64.tar.gz node-v$2-linux-x64/LICENSE
	tar -xvf node-v$2-linux-x64.tar.gz node-v$2-linux-x64/bin/node
	mv node-v$2-linux-x64/LICENSE LICENSE
	mv node-v$2-linux-x64/bin/node node
	rm -r node-v$2-linux-x64
	mv node-v$2-linux-x64.tar.gz ../
	cd ../..

	echo "=== commit"
	git commit -a -m "update node.js to $1 $2"
	git checkout $2

	cd linux_x64

	echo "=== update linux version to $2"
	tar -xvf node-v$2-linux-x64.tar.gz node-v$2-linux-x64/LICENSE
	tar -xvf node-v$2-linux-x64.tar.gz node-v$2-linux-x64/bin/node
	mv node-v$2-linux-x64/LICENSE LICENSE
	mv node-v$2-linux-x64/bin/node node
	rm -r node-v$2-linux-x64
	rm node-v$2-linux-x64.tar.gz

	cd ../darwin_x64
	echo "=== update mac version to $2"
	echo GET https://nodejs.org/dist/v$2/node-v$2-darwin-x64.tar.gz in `pwd`
	curl -O https://nodejs.org/dist/v$2/node-v$2-darwin-x64.tar.gz
	tar -xvf node-v$2-darwin-x64.tar.gz node-v$2-darwin-x64/LICENSE
	tar -xvf node-v$2-darwin-x64.tar.gz node-v$2-darwin-x64/bin/node
	mv node-v$2-darwin-x64/LICENSE LICENSE
	mv node-v$2-darwin-x64/bin/node node
	rm -r node-v$2-darwin-x64
	rm node-v$2-darwin-x64.tar.gz

	cd ../win32_x64
	echo "=== update windows version to $2"
	echo GET https://nodejs.org/dist/v$2/x64/node.exe in `pwd`
	curl -O https://raw.githubusercontent.com/nodejs/node/master/LICENSE
	curl -O https://nodejs.org/dist/v$2/x64/node.exe

	cd ..
	git commit -a -m "update node.js to $2"
	git checkout $1
else
	git commit -a -m "update node.js to $1"
	git checkout $1	
fi
