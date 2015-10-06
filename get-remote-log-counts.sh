#!/bin/bash
# Get line counts from remote Acquia logs - each line is an event
# Useful for monitoring numbers of errors for example

# adjust  logfilepattern to suit 
# for example,  drupal and error logs for Sept and Oct 2015:
# logfilepattern="drupal-watchdog*201510*.gz php*201510*gz error*201510*gz"

logfilepattern="drupal*201509*gz drupal*201510*gz php*201509*gz php*201510*gz error*201509*gz error*201510*gz"



function getlogcounts {
	echo  getting counts from: "$1" "$2"	
	ssh  $1 "
	cd $2
	#echo $logfilepattern
	for f in \`ls $logfilepattern 2> /dev/null\`;  #redirect errors i.e. not founds to /dev/null
	    do
	        echo -n \`ls \$f | grep -oE '[[:digit:]]'{8}\`  #extract the date from the filename
	        echo -n "\""    "\""
	         echo -n \`hostname -s\`
	        echo -n "\""    "\"" 
	        #echo -n \$f
	        echo -n \`ls \$f | cut -d. -f1\` #extract the log type
	        echo -n "\""    "\"" 
	        zcat \$f | wc -l
	done"
}



if [ $# -eq 0 ]
	then
		echo "no argument - use arg = [public|public-stage|public-stage2|mygsb|mygsb-stage|mygsb-stage2]"
		exit 1
fi
if [[ $1 == "public" ]];
	then
		echo "Getting logs counts from public prod ded-1528"
		server="gsbpublic.prod@ded-1528.prod.hosting.acquia.com "
		logdir="/var/log/sites/gsbpublic/logs/ded-1528"
		getlogcounts $server $logdir 

		 echo "Getting logs counts from public prod ded-1529"
		server="gsbpublic.prod@ded-1529.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbpublic/logs/ded-1529"
		getlogcounts $server $logdir 
elif [[ $1 == "mygsb" ]]
	then
		echo "Getting logs counts from mygsb prod ded-1528"
		server="gsbmygsb.prod@ded-1528.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbmygsb/logs/ded-1528"
		getlogcounts $server $logdir 

		 echo "Getting logs counts from mygsb prod ded-1529"
		server="gsbmygsb.prod@ded-1529.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbmygsb/logs/ded-1529"
		getlogcounts $server $logdir 	
elif [[ $1 == "public-stage" ]]
	then
		echo "Getting logs counts from public stage "
		server="gsbpublic.test@staging-9591.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbpublicstg/logs/staging-9591"
		getlogcounts $server $logdir 
elif [[ $1 == "public-stage2" ]]
	then
		echo "Getting logs counts from public stage2 "
		server="gsbpublic.test@staging-9591.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbpublicstg2/logs/staging-9591"
		getlogcounts $server $logdir 
elif [[ $1 == "mygsb-stage" ]]
	then
		echo "Getting logs counts from mygsb stage "
		server="gsbmygsb.test@staging-9591.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbmygsbstg/logs/staging-9591"
		getlogcounts $server $logdir 
elif [[ $1 == "mygsb-stage2" ]]
	then
		echo "Getting logs counts from mygsb stage2 "
		server="gsbmygsb.test@staging-9591.prod.hosting.acquia.com"
		logdir="/var/log/sites/gsbmygsbstg2/logs/staging-9591"
		getlogcounts $server $logdir 
else
		echo "don't know how to handle arg $1"
fi
