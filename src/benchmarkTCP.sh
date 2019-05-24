# !/bin/sh

#creating default content variables
count=$1

#if no parameters given then ask parameters
if [ -z "$1" ];then
    count=1
fi

IP=$2
PORT=$3

if [ -z "$2" ];then
    IP=localhost
fi
if [ -z "$3" ];then
    PORT=12345
fi

cd Network

for ((i=1;$i<=count;i++))
do
    bash client.sh $2 $3
done
