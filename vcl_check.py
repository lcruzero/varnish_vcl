#!/usr/bin/python2.6

import requests
import re
import sys
import argparse

def main(varnish_proxy,filename):
    #send stdout to tmp file
    sys.stdout = open('/tmp/vcl_check_results.txt', 'w')
    processed_paths = []
    paths = open(filename).readlines()

    #pattern to find unparsed ESI and 404 placeholders
    patterns = re.compile('("esi:include.*"|BACKEND)')

    for path in paths:
        #use first value from filename as our host header
        path_list = path.split("/")
        h_header = path_list.pop(0)
        path = "/".join(path_list)
        headers = {'Host': h_header}

        #URLs to passed onto varnish server
        f_url = "http://" + varnish_proxy + "/" + str(path).strip()
        print '****START****'
        print f_url
        print "Using host header: ", h_header
        r = requests.get(f_url, headers=headers)
        match = re.findall(patterns, r.text)

        #return request status
        print '****RETURN CODE: ', r.status_code
        if match:
            print('BACKEND ERROR: ESI or PlaceHolder found')
        else:
            print ('no error')
        print '****END****'
        print '-----------'

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='pass a varnish_proxy host, filename with paths and host header options to requests module, return status code, ESI includes if any found, and detect instance of VARNISH PlaceHolder HTML for non 200/301/304 return codes')
    parser.add_argument('-p','--varnsih_proxy', dest='varnish_proxy',help='pass varnish_proxy host through which request will be sent', required=True)
    parser.add_argument('-f','--filename-with-paths',dest='filename', help='paths to pass onto host header', required=True)
    args = parser.parse_args()

    main(args.varnish_proxy,args.filename)
