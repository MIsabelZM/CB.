require 'rubygems'
require 'active_record'
require 'mysql2'
require 'pry'
require 'open-uri'
require './company.rb'
require './person.rb'
require './office.rb'
require 'uri'
require './update.rb'
require 'net/http'
require "rest-client"
require './error.rb'

class CrunchBase_to_mysql

	def initialize
		connection
		@records = Update.find(1)

		@i = 0
		@errors = 0

		# Your user key. Get yours here https://developer.crunchbase.com/
		@users_key = [""]
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

	def add_info_to_table_companies
		page = @records.last_record_companies
		begin
			#binding.pry
			url = create_url("organizations","",page)
			puts "Reading #{url}"

			result = read_url(url)
			result['data']['items'].each do |organization|
				name = organization['name']
				path = organization['path']
				Company.create(name: name, path: path)
			end
			next_url = result['data']['paging']['next_page_url']

			page = page + 1
			
		end while next_url != nil
		@records.update(last_record_companies: page)
	end

	def add_info_to_table_people
		count = @records.last_record_people 
		organizations = Company.offset(count)
		organizations.each do |organization|
			permalink = create_permalink(organization.path)
			url = create_url("organization",permalink,1)
			puts "#{count} Reading #{url}" 

			begin
				url_exist = URI.parse(url)
				req = Net::HTTP.new(url_exist.host, url_exist.port)
				res = req.request_head(url_exist.path)
			  
				result = read_url(url)
				if result['data']['response'] != false
					if result['data']['properties']['homepage_url'] != nil 
						homepage = result['data']['properties']['homepage_url']
						domain = URI.parse(homepage).host
						if domain.downcase.include? "www" then
								domain = domain.split("www.").last
						end
					else
						domain = permalink.gsub(/[^A-Za-z.]/, '') + '.com'
					end

					if result['data']['relationships']['current_team'] != nil 
						result['data']['relationships']['current_team']['items'].each do |person|
							name = person['first_name']
							last_name = person['last_name']
							title = person['title']
							company = result['data']['properties']['name'] 
							permalink = result['data']['properties']['permalink']
							Person.create(name: name, last_name: last_name, domain: domain, title: title, company: company, permalink: permalink)
						end
					end

					if result['data']['relationships']['offices'] != nil 
						result['data']['relationships']['offices']['items'].each do |office|
							name = office['name']
							address = office['street_1']
							region = office['region']
							country = office['country_code']
							permalink = result['data']['properties']['permalink']
							Office.create(name: name, address: address, region: region, country: country, permalink: permalink)
						end
					end
				end
			rescue
						puts "Error reading or parsing #{url}"	
						Error.create(url: url)
						if @errors >= 5
							@records.update(last_record_people: count -5)	
							exit
						end 
						count = count + 1
						@errors = @errors + 1
						next
			end
			count = count + 1
		end
			 @records.update(last_record_people: count)	
	end


	# Type can be organizations | organization | people | person | products | product | fundingRound | acquisition | fundraise
	# Permalink is an substring of the organization's path.  - Use create_permalink to get an array with all paths.
	# page is the number of the page that you want to consult.
	def create_url (type,permalink,page)
		base_url = "http://api.crunchbase.com/v/2/"
		if permalink == "" then
			url = "#{base_url}#{type}?page=#{page}&user_key=#{@users_key[@i]}"
		else
			url = "#{base_url}#{type}/#{permalink}?page=#{page}&user_key=#{@users_key[@i]}"
		end
		@i += 1

		if @i == @users_key.size then 
			@i = 0
		end

		return url 
	end


	def read_url(url)
		sleep(1)
		JSON.parse(open(url).read)
	end 

	def create_domain(homepage)
		if homepage != nil
			if homepage.downcase.include? "www" then
				homepage.split("www.").last
			else 
				homepage.split("\/\/").last
			end
		end 
	end

	# Extract permalinks of an array of paths
	# Ex: if path=>"organization/futurebooks" then permalink =>futurebooks
	def  create_permalink(path)
		#puts "Path is really empty? \n #{paths}"
		if path != "" and path != nil then
					if path.include? "\/" then
						permalink = path.split("\/").last
					end
		else
			permalink = ""
		end
		return permalink
	end 

end 

a = CrunchBase_to_mysql.new
a.add_info_to_table_people

