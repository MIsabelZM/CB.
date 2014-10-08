require 'active_record'
require 'mysql2'

class Company < ActiveRecord::Base;
	validates :path, uniqueness: true
 end
