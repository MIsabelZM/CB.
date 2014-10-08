#!/usr/bin/env python

import string
import httplib, sys
from socket import *
import re
import getopt
from discovery import *
import hostchecker

def usage():
 print "Check params"


def start(argv):
	if len(sys.argv) < 4:
		usage()
		sys.exit()
	try :
	       opts, args = getopt.getopt(argv, "l:d:b:s:v:f:")
	except getopt.GetoptError:
  	     	usage()
		sys.exit()
	start=0
	host_ip=[]
	filename=""
	bingapi="yes"
	start=0
	for opt, arg in opts:
		if opt == '-l' :
			limit = int(arg)
		elif opt == '-d':
			word = arg	
		elif opt == '-s':
			start = int(arg)
		elif opt == '-v':
			virtual = arg
		elif opt == '-f':
			filename= arg
		elif opt == '-b':
			engine = arg
			if engine not in ("google", "linkedin", "pgp", "all","google-profiles","exalead","bing","bing_api","yandex"):
				usage()
				print "Invalid search engine, try with: bing, google, linkedin, pgp"
				sys.exit()
			else:
				pass
	if engine == "google":
		search=googlesearch.search_google(word,limit,start)
		search.process()
		all_emails=search.get_emails()
		all_hosts=search.get_hostnames()
	if engine == "exalead":
		search=exaleadsearch.search_exalead(word,limit,start)
		search.process()
		all_emails=search.get_emails()
		all_hosts=search.get_hostnames()
	elif engine == "bing" or engine =="bingapi":	
		
		search=bingsearch.search_bing(word,limit,start)
		if engine =="bingapi":
			bingapi="yes"
		else:
			bingapi="no"
		search.process(bingapi)
		all_emails=search.get_emails()
		all_hosts=search.get_hostnames()
	elif engine == "yandex":# Not working yet
		
		search=yandexsearch.search_yandex(word,limit,start)
		search.process()
		all_emails=search.get_emails()
		all_hosts=search.get_hostnames()
	elif engine == "pgp":

		search=pgpsearch.search_pgp(word)
		search.process()
		all_emails=search.get_emails()
		all_hosts=search.get_hostnames()
	elif engine == "linkedin":

		search=linkedinsearch.search_linkedin(word,limit)
		search.process()
		people=search.get_people()
		sys.exit()
	elif engine == "google-profiles":
		
		search=googlesearch.search_google(word,limit,start)
		search.process_profiles()
		people=search.get_profiles()
		

		sys.exit()
	elif engine == "all":
		all_emails=[]
		all_hosts=[]
		virtual = "basic"
		
		search=googlesearch.search_google(word,limit,start)
		search.process()
		emails=search.get_emails()
		hosts=search.get_hostnames()
		all_emails.extend(emails)
		all_hosts.extend(hosts)
		
		search=pgpsearch.search_pgp(word)
		search.process()
		emails=search.get_emails()
		hosts=search.get_hostnames()
		all_hosts.extend(hosts)
		all_emails.extend(emails)
		
		bingapi="yes"
		search=bingsearch.search_bing(word,limit,start)
		search.process(bingapi)
		emails=search.get_emails()
		hosts=search.get_hostnames()
		all_hosts.extend(hosts)
		all_emails.extend(emails)
		
		search=exaleadsearch.search_exalead(word,limit,start)
		search.process()
		emails=search.get_emails()
		hosts=search.get_hostnames()
		all_hosts.extend(hosts)
		all_emails.extend(emails)
		
		search=linkedinsearch.search_linkedin(word,limit)
		search.process()
		people=search.get_people()
		
	if all_emails ==[]:
		print "No emails found"
	else:
		for emails in all_emails:
			print emails
	print "\n"
	
	recursion=None	
	if recursion:
		limit=300
		start=0
		for word in vhost:
			search=googlesearch.search_google(word,limit,start)
			search.process()
			emails=search.get_emails()
			hosts=search.get_hostnames()
	else:
		pass
	if filename!="":
		file = open(filename,'w')
		file.write('<theHarvester>')
		for x in all_emails:
			file.write('<email>'+x+'</email>')
		for x in all_hosts:
			file.write('<host>'+x+'</host>')
		for x in vhosts:
			file.write('<vhost>'+x+'</vhost>')
		file.write('</theHarvester>')
		file.close
		print "Results saved in: "+ filename
	else:
		pass

		
if __name__ == "__main__":
        try: start(sys.argv[1:])
	except:
		sys.exit()

