#!/bin/bash

# This test checks for a 200 response and a legit file size.
# Optimally, this would loop through an array of URLs.

n=0;
declare -i n;

# START

response_status_code=$(curl -H 'Host: www.al.com' --write-out %{http_code} --silent --output /dev/null 'http://127.0.0.1/')
#echo $response_status_code;
if [ $response_status_code -eq 200 ]
then
        n=$n+0;
else
        n=$n+1;
fi
response_content_length=$(curl -H 'Host: www.al.com' -sI 'http://127.0.0.1/' | grep Content-Length | awk '{print $2}')
#echo $response_content_length;
if [ $response_content_length > 5000 ]
then
        n=$n+0;
else
        n=$n+1;
fi

response_status_code=$(curl -H 'Host: www.cleveland.com' --write-out %{http_code} --silent --output /dev/null 'http://127.0.0.1/')
#echo $response_status_code;
if [ $response_status_code -eq 200 ]
then
        n=$n+0;
else
        n=$n+1;
fi
response_content_length=$(curl -H 'Host: www.cleveland.com' -sI 'http://127.0.0.1/' | grep Content-Length | awk '{print $2}')
#echo $response_content_length;
if [ $response_content_length > 5000 ]
then
        n=$n+0;
else
        n=$n+1;
fi

# END

if [ $n -eq 0 ]
then
        echo "pass";
else
        exit 1;
fi
echo $n;

