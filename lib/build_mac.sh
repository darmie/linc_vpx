#!/bin/bash

MACOSX_DEPLOYMENT_TARGET=10.9

cd libvpx/third_party
# rm libyuv/include/libyuv.h libyuv/include/libyuv/compare_row.h
mv libyuv/include tmp/
mv libyuv/source tmp/
mv libyuv/LICENSE tmp/
rm -rf libyuv
mkdir libyuv
mv tmp/* libyuv/

cd ../..

mkdir build
cd build
make clean
../libvpx/configure --enable-vp8 --enable-vp9 --enable-avx2 --enable-avx512  --enable-libyuv --disable-docs --disable-examples --disable-unit-tests --extra-cxxflags="-mmacosx-version-min=10.9" --extra-cflags="-mmacosx-version-min=10.9"

make
rm -rf ../macosx64
mkdir ../macosx64
cp *.a ../macosx64

