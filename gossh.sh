#!/bin/bash

# ssh into remote Acquia servers
# Creates new tabs in a mac terminal window appropriate for the environment
# For public gossh.sh public creates 2 new tabs with ssh to the two prod servers for users gsbpublic and gsbmygsb
# For stage gossh.sh stage creates 2 new tabs with ssh in stage server for users gsbmygsb.test and gsbpublic.test

#assumes you have your ssh keys set up under ~/.ssh
#if not, read man ssh

function new_tab() {
  TAB_NAME=$1
  COMMAND=$2
  osascript \
    -e "tell application \"Terminal\"" \
    -e "tell application \"System Events\" to keystroke \"t\" using {command down}" \
    -e "do script \"printf '\\\e]1;$TAB_NAME\\\a'; $COMMAND\" in front window" \
    -e "end tell" > /dev/null
}



if [ $# -eq 0 ]
	then
		echo "no argument - use gossh public or gossh mygsb"
		exit 1
fi

if [ $1 == "public" ]
	then
		echo "going to public"
		new_tab "PublicProd1529" "ssh gsbpublic.prod@ded-1529.prod.hosting.acquia.com"
		new_tab "PublicProd1528" "ssh gsbpublic.prod@ded-1528.prod.hosting.acquia.com"
elif [ $1 == "mygsb" ]
	then
		echo "going to mygsb"
		new_tab "MyGSBProd1529" "ssh gsbmygsb.prod@ded-1529.prod.hosting.acquia.com"
		new_tab "MyGSBProd1528" "ssh gsbmygsb.prod@ded-1528.prod.hosting.acquia.com"
elif [ $1 == "stage" ]
	then
		echo "going to stage"
		new_tab "MyGSBStage" "ssh gsbmygsb.test@staging-9591.prod.hosting.acquia.com"
		new_tab "Public Stage" "ssh gsbpublic.test@staging-9591.prod.hosting.acquia.com"
else
		echo "don't know how to go to $1"
fi
