# !/bin/bash

#creating default content variables
count=$1

#if no parameters given then ask parameters
if [ -z "$1" ];then
    count=1
fi

datadir='FILES'
cd $datadir

for ((i=1;$i<=count;i++))
do
    echo "Creating "$i"th data"
    FOLDERNAME='TEMP'`date +"%T"`
    rm -rf $FOLDERNAME
    mkdir $FOLDERNAME
    FILENAME='../pc.dat'
    if [ ! -f $FILENAME ]
    then
        > $FILENAME
    fi
    for file in *.dat
    do
        toWrite=`stat --printf="%s" $file`
        toWrite+=" "
        toWrite+=`(time cp $file $FOLDERNAME/$file) 2>&1 >/dev/null \
                    | grep real | awk '{print $2}' \
                    | awk 'BEGIN {FS="[m,s]";}{ print (($1*60)+$2)"."$3}'`
        echo $toWrite >> $FILENAME
    done
    rm -rf $FOLDERNAME
done
