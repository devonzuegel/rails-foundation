class Investor < ActiveRecord::Base
	validates :permalink, uniqueness: true
end