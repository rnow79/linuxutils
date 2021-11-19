#!/bin/bash
# Author: Arnau Carrasco <arnau.carrasco@gmail.com>
#
# The script gets the first pod on kubernetes master node matching $match and
# executes a command interactive and with tty. The script is named kubeshell
# cos it executes a shell, but the command can be changed

match="^shell-"
cmd="/bin/bash"

shellPod=`kubectl get pods --no-headers | grep $match | head -n 1 | expand | tr -s " " | cut -d " " -f1`
if [ "$shellPod" == "" ] ; then
 echo "No shell pod found."
 exit 1;
fi
kubectl exec -i --tty $shellPod -- $cmd
