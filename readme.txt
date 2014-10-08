How to run:
	If you want to find information about members of the company.
	(Make sure that in the last line of the code you run the right method. It means that the last line should be "a.add_info_to_table_people")
		ruby crunchbase_to_mysql.rb

	If you want to find information about all companies.
	(Make sure that in the last line of the code you run the right method. It means that the last line should be "a.add_info_to_table_companies")
		ruby crunchbase_to_mysql.rb

	If you want to find the emails for the people who is in People table.
	(It looks for the contact information of the people who has the column "contact information" NULL and then updates it with the information found)
		ruby info_recollect

DB - Mysql.
(Copy of the data base, updated at Sep 29, 2014)
	* CrunchBase_2014-09_29.sql

Models - Using Active Record.
	* company.rb
	* Person.rb
	* office.rb

To get info from CrunchBase.
 	* crunchbase_to_mysql.rb
 	* info_recollect.rb

Script that finds any email.
I got it from github.com/the4dpatrick/find-any-email and made it some changes
	* info_recollect.rb
	* info_scrapper.rb
	* profile.rb

