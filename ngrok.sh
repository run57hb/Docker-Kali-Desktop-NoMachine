#!/bin/bash
stty intr ""
stty quit ""
stty susp undef

rm -rf ngrok ngrok.zip ng.sh > /dev/null 2>&1
echo "Downloading ngrok..."
wget -O ngrok.zip https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip > /dev/null 2>&1
unzip ngrok.zip > /dev/null 2>&1
