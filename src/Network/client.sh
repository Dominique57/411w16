# !/bin/bash
MYIP=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' \
             | grep -Eo '([0-9]*\.){3}[0-9]*' \
             | grep -v '127.0.0.1'`
IP=$1
PORT=$2

if [ -z "$1" ];then
    IP=localhost
fi
if [ -z "$2" ];then
    PORT=12345
fi

echo current ip is : $MYIP
echo sending packet to : $IP
echo trying to connect on port $PORT
echo 

echo Trying to connect . . .
echo

# wait server connected
str=$((netcat -zv $IP $PORT) 2>&1)
if [[ $str =~ ^.*failure.*$ ]]
then
    echo unvalid hostname or port
    exit
fi
while [[ $str =~ ^.*refused.*$ ]]; do
    sleep .2
    str=$((netcat -zv $IP $PORT) 2>&1)
    if [[ $str =~ ^.*failure.*$ ]]
    then
        echo unvalid hostname or port
        exit
    fi
done

echo Connected!
echo

# launch files
FILENAME="../tcp.dat"
if [ ! -f $FILENAME ]
then
    > $FILENAME
fi

for file in ../FILES/*.dat
do
    echo $file
    toWrite=`stat --printf="%s" $file`
    toWrite+=" "
    toWrite+=`(time nc -q 0  $IP $PORT < $file) 2>&1 >/dev/null \
                | grep real | awk '{print $2}'\
                | awk 'BEGIN {FS="[m,s]";}{ print (($1*60)+$2)"."$3}'`
    echo $toWrite >> $FILENAME
done
