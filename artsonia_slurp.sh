#!/bin/bash

# 2018-04 tmuka 
# description: this script is to find a way to export and save a backup of my child school art projects from artsonia.com
# to use, run the script passing the students artist id number as the only argument to download all the art into the current folder
# eg run
# artsonia_slurp.sh 0000000

# find the "slideshow" url for the student artist id
# eg for https://www.artsonia.com/artists/portfolio.asp?id=0000000&artid=0000000
# the slideshow url is
# https://www.artsonia.com/slideshow.asp?artist=0000000

#cat logan.txt | grep -e src | 


if [ -n "$1" ]
	then ARTIST_ID=$1
		echo "$ARTIST_ID" >> .artsonia_slurp.log
	else 
		echo 'Error: pass the students artist portfolio id number as the argument. get this from the portfolio.asp?id='
		exit
fi
if [ -n "$2" ]
	then 
		GRADE=$2
		GRADE_MSG="from grade \"$GRADE\""
	else 
		GRADE=""
		GRADE_MSG=""
fi

read -rsp $"Press any key to download pictures for artist \"$ARTIST_ID\" $GRADE_MSG, ctrl+c to abort..." -n1 key

curl -s https://www.artsonia.com/slideshow.asp?artist=$ARTIST_ID | egrep 'src.*screenname' | sed 's;Grade ;Grade_;g' | sed "s;{src: '\(.*\)',screenname: '\(.*\)',artid: \(.*\),grade: '\(.*\)'}.*; \[\[ -e \"\2.\4.\3.artsonia.jpg\" \]\] || curl --remote-time -sS \1 -o \"\2.\4.\3.artsonia.jpg\";g" | xargs -t -0 -i bash -c "{}"

