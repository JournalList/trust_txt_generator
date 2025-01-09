#!/bin/bash
# 
# JournalList.net - Generates TRUST.txt files by scraping website using WordPress plugin REST API
#
# Usage: sitescrape.sh [URL | LIST.csv]
# URL - the URL of the website for which to generate a TRUST.txt file
# LIST.csv - a list of URLs of websites for which to generate TRUST.txt files 
#----
# If argument is a file then process a list the list of URLs
#
if [ -f $1 ] 
then
    URLS=$( cat $1 | sed -e 's/\r//g' )
    if [[ $1 == *"/"* ]]
    then
        DIR=$( echo $1 | sed -e 's/\/.*$//' )
    else
        DIR="."
    fi
else
    URLS=$1
    DIR="."
fi
# 
# Process the URLs
#
for URL in $URLS
do
    DOMAIN=$(echo $URL | sed -e 's/http:\/\///' -e 's/https:\/\///' -e 's/\///')
    TRUST="-trust.txt"
    FILENAME="${DIR}/${DOMAIN}${TRUST}"
    DATA="{\"url\": \"$URL\"}"
    echo "Processing:" $URL
    TYPE="Content-Type: application/json"
    CODEPOINT="https://journallist.net/wp-json/TRUST-txt/v1/generate"
    # curl -X POST "https://journallist.net/wp-json/TRUST-txt/v1/generate" -H "Content-Type: application/json" -d "{\"url\": \"$URL\"}"
    curl -X POST $CODEPOINT -H "$TYPE" -d "$DATA" | jq | sed -e "s/,$//" -e "/\[/d" -e "/\]/d" -e "s/\"//g" -e "s/^  //" > $FILENAME
done