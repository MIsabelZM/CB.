require 'active_record'
require 'mysql2'

class Person < ActiveRecord::Base;
	validates_uniqueness_of :name, scope: [:last_name, :domain, :title]
end