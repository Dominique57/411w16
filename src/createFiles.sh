# !/bin/bash 
# create files


declare -a ARRAY=('' 'KB' 'MB' 'GB')

LENGTH=3

FOLDERNAME='FILES'
rm -rf $FOLDERNAME
mkdir $FOLDERNAME

for ((i=0; i<$LENGTH; i++))
do
    TYPE=${ARRAY[i]}
    for ((j=1; j<=100; j*=10))
    do
        VOLUME=$j$TYPE
        FILENAME=$FOLDERNAME/file$VOLUME.dat
        head -c $VOLUME /dev/urandom > $FILENAME
    done
done

exit
