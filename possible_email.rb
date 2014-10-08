require 'possible_email'
require 'active_record'
require 'mysql2'
require 'pry'
require './person.rb'
require './info_scrapper.rb'
require './update.rb'

class InfoRecollect
	def initialize
		connection
	end

	def get_contact_info
		person = Person.limit(20).offset(6)
		person.each do |record|
			puts "#{record.name} #{record.last_name} #{record.domain}"
			profiles = PossibleEmail.search(record.name, record.last_name, record.domain)
		end
	end

	def clean_characters(value)
		value.gsub(/[^0-9A-Za-z.]/, '')
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

a = InfoRecollect.new
a.get_contact_info