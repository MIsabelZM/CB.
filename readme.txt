How to run:
-----------

 * If you want to find information about members of the company.
	(Make sure that in the last line of the code you run the right method. It means that the last line should be "a.add_info_to_table_people")
		ruby crunchbase_to_mysql.rb
 
 * If you want to find information about all companies.
	(Make sure that in the last line of the code you run the right method. It means that the last line should be "a.add_info_to_table_companies")
		ruby crunchbase_to_mysql.rb

 * If you want to find the emails for the people who is in People table.
	(It looks for the contact information of the people who has the column "contact information" NULL and then updates it with the information found)
		ruby info_recollect



Database schema - MySQL:
------------------------
 + CrunchBase_2014-10_08.sql

Models - Using Active Record:
-----------------------------
 + company.rb
 + person.rb
 + office.rb
 + error.rb
 + update.rb

Scripts to find emails:
----------------------
 * Find_any_emails - github.com/the4dpatrick/find-any-email (Have some changes)
	 + info_recollect.rb
	 + info_scrapper.rb
	 + profile.rb

 * theHarvester - github.com/bireme/harvester
   + discovery
   + COPYING
   + hostchecker.py
   + LICENSES
   + parser.py
   + theHarvester.py
   + TODO
   + Version

