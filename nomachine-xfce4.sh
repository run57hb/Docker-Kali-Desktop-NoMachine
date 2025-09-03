wget -O ng.sh https://raw.githubusercontent.com/kmille36/Docker-Kali-Desktop-NoMachine/main/ngrok.sh > /dev/null 2>&1
chmod +x ng.sh
./ng.sh
...
./ngrok authtoken $CRP
...
docker run --rm -d --network host --privileged --name nomachine-xfce4-kali \
   -e PASSWORD=123456 -e USER=user --cap-add=SYS_PTRACE --shm-size=1g \
   thuonghai2711/nomachine-kali-desktop:latest
