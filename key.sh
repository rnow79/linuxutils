#!/bin/bash
key="$1"
if [ "$key" == "" ] ; then echo "Usage: key.sh <key>"; exit 1; fi

gpg --keyserver hkp://subkeys.pgp.net --recv-keys "$key"
gpg --export --armor "$key" | apt-key add -
