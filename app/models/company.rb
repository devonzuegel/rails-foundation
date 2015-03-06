class Company < ActiveRecord::Base
  include Scopable
	validates :permalink, uniqueness: true
end