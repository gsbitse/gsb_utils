#!/bin/bash
#
# sync remote Acquia log files into an assumed local directory structure
# if the directory structure doesn't exist yet, then create it and then sync
#
# this is the directory structure assumed:
#logs
#  public
#    ded-1528
#    ded-1529
#  mygsb
#    ded-1528
#    ded-1529
#  public-stage
#  public-stage2


LOGHOME="/Users/max/Projects/LogHandler/working/logs"

#These will just fail siliently if the directories don't exist
mkdir -p $LOGHOME/public/ded-1528
mkdir -p $LOGHOME/public/ded-1529
mkdir -p $LOGHOME/mygsb/ded-1528
mkdir -p $LOGHOME/mygsb/ded-1529
mkdir -p $LOGHOME/public-stage
mkdir -p $LOGHOME/public-stage2

echo "Getting public logs from ded-1528"
cd $LOGHOME/public/ded-1528
rsync -v -v -t -P --ignore-existing gsbpublic.prod@ded-1528.prod.hosting.acquia.com:/var/log/sites/gsbpublic.prod/logs/ded-1528/*.gz .

echo "Getting public logs from ded-1529"
cd $LOGHOME/public/ded-1529
rsync -v -v -t -P --ignore-existing gsbpublic.prod@ded-1529.prod.hosting.acquia.com:/var/log/sites/gsbpublic.prod/logs/ded-1529/*.gz .

echo "Getting mygsb logs from ded-1528"
cd $LOGHOME/mygsb/ded-1528
rsync -v -v -t -P --ignore-existing gsbmygsb.prod@ded-1528.prod.hosting.acquia.com:/var/log/sites/gsbmygsb.prod/logs/ded-1528/*.gz .

echo "Getting mygsb logs from ded-1529"
cd $LOGHOME/mygsb/ded-1529
rsync -v -v -t -P --ignore-existing gsbmygsb.prod@ded-1529.prod.hosting.acquia.com:/var/log/sites/gsbmygsb.prod/logs/ded-1529/*.gz .

echo "Getting public-stage logs from staging-9591"
cd $LOGHOME/public-stage
rsync -v -v -t -P --ignore-existing gsbpublic.test@staging-9591.prod.hosting.acquia.com:/var/log/sites/gsbpublicstg/logs/staging-9591/*.gz .

echo "Getting public-stage2 logs from staging-9591"
cd $LOGHOME/public-stage2
rsync -v -v -t -P --ignore-existing gsbpublic.test@staging-9591.prod.hosting.acquia.com:/var/log/sites/gsbpublicstg2/logs/staging-9591/*.gz .


