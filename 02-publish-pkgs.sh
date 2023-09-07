#!/bin/bash
for pkg in pkg-a pkg-b pkg-c
do
    cd $pkg || exit
    poetry build
    devpi upload
    cd ..
done
