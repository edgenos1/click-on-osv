#!/bin/bash

echo "Init Submodules"
git submodule update --init
echo "Building DPDK"
cd dpdk
git checkout osv-head
cd ..
#adapted from https://github.com/syuu1228/dpdk/blob/osv-head/lib/librte_eal/osvapp/capstan/GET
export RTE_SDK=`readlink -f dpdk`
export RTE_TARGET=x86_64-native-osvapp-gcc
OSV_SDK=`readlink -f osv`
cd $RTE_SDK 
make install T=$RTE_TARGET OSV_SDK=$OSV_SDK
cd ..
mkdir -p img_build
cp -fa $RTE_SDK/x86_64-native-osvapp-gcc/lib/libintel_dpdk.so img_build/
#build click
echo "Building Click"
#git clone https://github.com/lmarcuzzo/click
cd click
./configure --enable-dpdk --enable-user-multithread --disable-linuxmodule CXXFLAGS=""