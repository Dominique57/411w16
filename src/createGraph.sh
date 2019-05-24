# !/bin/bash
file1="pc.dat"
file2="tcp.dat"
if [ -f "$file1" ]
then
    python3 python.py $file1
fi

if [ -f "$file2" ]
then
    python3 python.py $file2
fi

