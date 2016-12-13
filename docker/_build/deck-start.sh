#!/bin/bash

echo "Applying modifications from deck-start.sh"

{
#check if /srv/jekyll is empty and if so, create a new site.
#if [ ! -f  "$(ls /srv/jekyll/ -A | grep -v "_site")"  ]; then
if test -z "$(ls -A $1| grep -v _site )"; then
#if [ ! -f [ "$(ls /srv/jekyll/ -A | grep -v "_site")" ] ]; then
    echo "Creating new site"
    jekyll new . --force;
    echo "Building new site"
    jekyll build;
else
echo "/srv/jekyll not empty,  skipping new site creation"
fi
}

echo "Starting jekyll server"
jekyll serve --watch --incremental --force_polling