require 'rubygems'
require 'active_record'
require 'mysql2'
require 'pry'
require 'open-uri'
require './company.rb'
require './person.rb'
require 'uri'
require './update.rb'
require 'net/http'
require "rest-client"
require './error.rb'

class AddingDomains

	def initialize
		connection
		puts "Connection established!"
	end


	#Get domain from People table
	def get_domain
		companies_com = Company.where(all_emails: nil)

		if !companies_com.empty?
			companies_com.each do |company|
				company_name = company.name
				puts company_name
				companies_per = Person.where(company: company_name)
				if !companies_per.empty?
					add_all_emails(company_name, companies_per[0].domain)
				end
			end
		end
	end

	#Add domain to Companies Table
	def add_all_emails(company_name, company_domain)
		company = Company.where(name:company_name, all_emails: nil)

		if !company.empty? 
			all_emails = run_theHarvester(company_domain)
			company[0].update(all_emails: all_emails)
		end
	end

	# TheHarvester is a script written in python
	def run_theHarvester (domain)
				puts "TheHarvester.py is looking for #{domain}"
				all_emails = `python theHarvester-master/theHarvester.py -l 500 -b all -d #{domain}`
				return all_emails
	end


	def connection
		ActiveRecord::Base.establish_connection(
		  :adapter => "mysql2",
		  :database => "CrunchBase",
		  :username => " ",     	#Your User Name 
		  :password => " ",				#Your Password
		  :host => "localhost"
		)
	end

end

a = AddingDomains.new
a.get_domain