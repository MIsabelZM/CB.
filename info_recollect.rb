require 'active_record'
require 'mysql2'
require 'pry'
require './person.rb'
require './info_scrapper.rb'
require './update.rb'

class InfoRecollect
	def initialize
		connection
		@records = Update.find(1)
	end

	def get_contact_info
		last = @records.last_record_info_contact
		person = Person.where(contact_information: nil).limit(200).offset(400)
		person.each do |record|

			puts "#{clean_characters(record.name)} #{clean_characters(record.last_name)} #{clean_characters(record.domain)}"
			if record.domain != 'empty'
				info = InfoScrapper.new(name: clean_characters(record.name), last_name: clean_characters(record.last_name), domain: clean_characters(record.domain))
				if info.get_results.empty?
					record.update(contact_information: "Not Found")
				else 
					puts info.get_results
					record.update(contact_information: info.get_results.join(", \n"))
				end	
			end
			last = last + 1
		end
		@records.update(last_record_info_contact: last)
	end

	def clean_characters(value)
		value.gsub(/[^0-9A-Za-z.]/, '')
	end

	def connection
		ActiveRecord::Base.establish_connection(
		  :adapter => "mysql2",
		  :database => "CrunchBase",
		  :username => "Isabel",
		  :password => "Pro",
		  :host => "localhost"
		)
	end
end

a = InfoRecollect.new
a.get_contact_info