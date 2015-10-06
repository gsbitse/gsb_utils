#!/bin/bash
LOGHOME="/Users/max/Projects/LogHandler/working/logs"

cd $LOGHOME/public/ded-1528

filename="*drupal*.gz php*.gz error*.gz"
for file in $filename
do
 echo -n `uname -n`; echo -n " "; echo -n $file; echo -n " "; gzcat $file | wc -l
done

cd $LOGHOME/public/ded-1529

filename="*drupal*.gz .gz php*.gz error*.gz"
for file in $filename
do
 echo -n `uname -n`; echo -n " "; echo -n $file; echo -n " "; gzcat $file | wc -l
done

