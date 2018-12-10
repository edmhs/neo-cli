#!/bin/bash
#
# This script starts four consensus and waits forever
#

screen -dmS node expect /neo-cli/cli.sh 

# sleep forever
while [ 1 ]                                                                
do                                                                         
  sleep 60 &                                                             
  wait $!                                                                
done