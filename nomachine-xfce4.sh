#!/bin/bash

# Download and run the latest ngrok script
wget -O ng.sh https://raw.githubusercontent.com/kmille36/Docker-Kali-Desktop-NoMachine/main/ngrok.sh > /dev/null 2>&1
chmod +x ng.sh
./ng.sh

# Fungsi untuk label jump
function goto {
    label=$1
    cmd=$(sed -n "/^:[[:blank:]]*${label}/{:a;n;p;ba};" "$0" | grep -v ':$')
    eval "$cmd"
    exit
}

: ngrok
clear
echo "Go to: https://dashboard.ngrok.com/get-started/your-authtoken"
read -p "Paste Ngrok Authtoken: " CRP
./ngrok config add-authtoken $CRP

clear
echo "Repo: https://github.com/kmille36/Docker-Kali-Desktop-NoMachine"
echo "======================="
echo "Choose ngrok region (for better connection):"
echo "======================="
echo "us - United States (Ohio)"
echo "eu - Europe (Frankfurt)"
echo "ap - Asia/Pacific (Singapore)"
echo "au - Australia (Sydney)"
echo "sa - South America (Sao Paulo)"
echo "jp - Japan (Tokyo)"
echo "in - India (Mumbai)"
read -p "Choose ngrok region: " CRP_REGION

# Start ngrok
./ngrok tcp --region $CRP_REGION 4000 &>/dev/null &

# Wait and verify ngrok tunnel is ready
sleep 1
if curl --silent http://127.0.0.1:4040/api/tunnels > /dev/null 2>&1; then
    echo "Ngrok tunnel OK!"
else
    echo "Ngrok Error! Please try again!"
    sleep 2
    goto ngrok
fi

# Start Docker container with Kali
docker run --rm -d --network host --privileged \
    --name nomachine-kali \
    -e PASSWORD=123456 \
    -e USER=user \
    --cap-add=SYS_PTRACE \
    --shm-size=1g \
    thuonghai2711/nomachine-kali-desktop:latest

clear
echo "NoMachine: https://www.nomachine.com/download"
echo "Done! NoMachine Information:"
echo -n "IP Address: "
curl --silent http://127.0.0.1:4040/api/tunnels | \
    sed -nE 's/.*public_url":"tcp:..([^"]*)".*/\1/p'
echo "User: user"
echo "Passwd: 123456"
echo "If VM can't connect, restart Cloud Shell then re-run script."

# Simple loop to keep shell alive (up to 12 hours)
seq 1 43200 | while read i; do
    echo -en "\r Running ....  $i s /43200 s"; sleep 0.1
    echo -en "\r Running ..... $i s /43200 s"; sleep 0.1
    echo -en "\r Running     . $i s /43200 s"; sleep 0.1
    echo -en "\r Running  .... $i s /43200 s"; sleep 0.1
    echo -en "\r Running   ... $i s /43200 s"; sleep 0.1
    echo -en "\r Running    .. $i s /43200 s"; sleep 0.1
done
