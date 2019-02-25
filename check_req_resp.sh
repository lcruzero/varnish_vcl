#!/bin/bash 
# checks results from check_vcl.py 

if less /tmp/vcl_check_results.txt | egrep -w '404|503|esi\:include|BACKEND'; then
  echo "found an error"
  exit 1

fi  

rm /tmp/vcl_check_results.txt
