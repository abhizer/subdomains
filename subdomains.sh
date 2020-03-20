#!/bin/bash

if [ $# -ne 1 ]
        then
                echo "Err: Syntax Error:"
                echo "Usage: ./subdomains <domain>"
        else
                echo "Complies the outputs of findomain, assetfinder and sublist3r!"
                echo " - @abhizer"

                filename=$1.txt
                echo "The output will be stored in $filename"
                findomain --output -t $1
                assetfinder $1 >> $filename
                python3 /root/tools/Sublist3r/sublist3r.py -d $1 -o $filename-sublist3r
                sed -s 's/<BR>/\n/g' $filename-sublist3r | tee $filename-sublist3r
                cat $filename-sublist3r >> $filename
                rm $filename-sublist3r
                sort -u $filename -o $filename
fi
