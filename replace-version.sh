#!/bin/sh

while true; do
    sed -i.bak -e s/1050/1070/ ./src/out_mac/Release/Breakpad/src/client/mac/sender/Breakpad.xib;
done
