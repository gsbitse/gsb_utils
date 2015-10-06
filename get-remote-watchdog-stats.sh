#!/bin/bash

# usage: get-remote-watchdog-stats.sh 

#adjust  logfilepattern to suit 
logfilepattern="drupal-watchdog.log-201509*gz drupal-watchdog.log-201510*gz"

#adjust how far to look
statdepth=20

# script based on gzcat drupal-watchdog.log-20151001.gz | cut -d"|" -f3 | sort | uniq -c | sort -nr | head -10

function statwatchdog {
	echo  analyzing drupal-watchdogs from : "$1" "$2"	
	ssh  $1 "
	cd $2
	#echo $logfilepattern
	for f in \`ls $logfilepattern 2> /dev/null\`;  #redirect errors i.e. not founds to /dev/null
	    do
	        reqs=\${f/watchdog/requests}
	        echo \`hostname -s\`
	        echo -n \$reqs \"   \"; zcat \$reqs | wc -l   
	        echo -n \$f \"   \"; zcat \$f | wc -l
	        zcat \$f  | cut -d \"|\" -f3 | sort | uniq -c | sort -nr | head -$statdepth
	done"
}



if [ $# -eq 0 ]
	then
		echo "no argument - use arg = [public|public-stage|public-stage2|mygsb|mygsb-stage|mygsb-stage2]"
		exit 1
fi
if [[ $1 == "public" ]];
	then
		echo "Getting drupal-watchdog details from public prod ded-1528"
		server="gsbpublic.prod@ded-1528.prod.hosting.acquia.com "
		logdir="/var/log/sites/gsbpublic/logs/ded-1528"
		statwatchdog $server $logdir 

		 echo "Getting drupal-watchdog from public prod ded-1529"
		server="gsbpublic.prod@ded-1529.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbpublic/logs/ded-1529"
		statwatchdog $server $logdir 
elif [[ $1 == "mygsb" ]]
	then
		echo "Getting logs counts from mygsb prod ded-1528"
		server="gsbmygsb.prod@ded-1528.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbmygsb/logs/ded-1528"
		statwatchdog $server $logdir 

		 echo "Getting logs counts from mygsb prod ded-1529"
		server="gsbmygsb.prod@ded-1529.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbmygsb/logs/ded-1529"
		statwatchdog $server $logdir 	
elif [[ $1 == "public-stage" ]]
	then
		echo "Getting logs counts from public stage "
		server="gsbpublic.test@staging-9591.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbpublicstg/logs/staging-9591"
		statwatchdog $server $logdir 
elif [[ $1 == "public-stage2" ]]
	then
		echo "Getting logs counts from public stage2 "
		server="gsbpublic.test@staging-9591.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbpublicstg2/logs/staging-9591"
		statwatchdog $server $logdir 
elif [[ $1 == "mygsb-stage" ]]
	then
		echo "Getting logs counts from mygsb stage "
		server="gsbmygsb.test@staging-9591.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbmygsbstg/logs/staging-9591"
		statwatchdog $server $logdir 
elif [[ $1 == "mygsb-stage2" ]]
	then
		echo "Getting logs counts from mygsb stage2 "
		server="gsbmygsb.test@staging-9591.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbmygsbstg2/logs/staging-9591"
		statwatchdog $server $logdir 
else
		echo "don know how to handle arg $1"
fi
