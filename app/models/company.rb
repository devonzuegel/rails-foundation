class Company < ActiveRecord::Base
	validates :permalink, uniqueness: true
end