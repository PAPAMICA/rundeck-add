#!/bin/bash
DEPOTFILES=$(ls /apps/rundeck/depot/*.yml 2> /dev/null)
for FILE in $DEPOTFILES; do
   mv $FILE /apps/rundeck/config/inventory/
   echo "$FILE added to inventory !"
done
DEPOTFILES=''
TRASHFILES=$(ls /apps/rundeck/depot/ -I "*.yml" 2> /dev/null)
for FILE in $TRASHFILES; do
   rm /apps/rundeck/depot/$FILE
   echo "$FILE deleted !"
done