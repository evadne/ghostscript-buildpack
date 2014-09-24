#!/bin/sh

# Usage:
# $ heroku build http://downloads.ghostscript.com/public/ghostscript-9.15.tar.gz -b <this script>

# capture root dir
root=$(pwd)
 
# change into subdir of archive
cd $root/ghostscript-*

# generate Makefile
./configure --prefix=/app/vendor

# fix Makefile for gnu make
cat Makefile | sed -e 's/^\.//g' > /tmp/Makefile; mv /tmp/Makefile Makefile
 
# make dirs
mkdir -p /app/vendor/bin
mkdir -p /app/vendor/man/man1
 
# configure and compile
make
make install INSTALL=install

# remove source files
rm -rf $root/*

# copy build artifacts back into the root
mv /app/vendor $root/
