#!/bin/bash
DEPOTFILE=/apps/rundeck/depot/*.yml
while true
do
    while [ ! -f "$DEPOTFILE" ]
        do
        echo "prout"
        sleep 2 # or less like 0.2
    done
    FILES=$(ls *.yml)
    for FILE in $FILES; do
        mv /apps/rundeck/depot/$FILE /apps/rundeck/inventory
    done
done