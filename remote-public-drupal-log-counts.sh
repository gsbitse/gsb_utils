#!/bin/bash


LOGHOME="/var/log/sites/gsbpublic/logs/ded-1528"

filename="*drupal*.gz php*.gz error*.gz"




ssh gsbpublic.prod@ded-1528.prod.hosting.acquia.com '
cd /var/log/sites/gsbpublic/logs/ded-1528
#filename="*drupal*.gz php*.gz error*.gz"
for file in $filename
do
	echo -n `ls $file | grep -oE '[[:digit:]]'{8}` ; echo -n  " " `hostname -s`; echo -n " " `ls $file | cut -d. -f1`; echo -n " "; zcat $file | wc -l
done
'
ssh gsbpublic.prod@ded-1529.prod.hosting.acquia.com '
cd /var/log/sites/gsbpublic/logs/ded-1529
filename="*drupal*.gz php*.gz error*.gz"
for file in $filename
do
	echo -n `ls $file | grep -oE '[[:digit:]]'{8}` ; echo -n  " " `hostname -s`; echo -n " " `ls $file | cut -d. -f1`; echo -n " "; zcat $file | wc -l
done
'



# cd $LOGHOME/public/ded-1529

# filename="*drupal*.gz .gz php*.gz error*.gz"
# for file in $filename
# do
#  echo -n `uname -n`; echo -n " "; echo -n $file; echo -n " "; gzcat $file | wc -l
# done