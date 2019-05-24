# !/bin/bash

function ctrl_c() {
    rm file*.dat
    exit
}
trap ctrl_c INT

IP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
             | grep -Eo '([0-9]*\.){3}[0-9]*' \
             | grep -v '127.0.0.1'`
PORT=$1

if [ -z "$1" ];then
    PORT=12345
fi
echo current ip is : $IP
echo server is open on port $PORT
echo 
echo press Ctr+C to Stop server

i=0
while true;
do
    nc -l $PORT > file$i.dat
    i=$((i+1))
done


