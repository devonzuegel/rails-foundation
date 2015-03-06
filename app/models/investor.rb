class Investor < ActiveRecord::Base
  include Scopable
	default_scope { order('created_at DESC') }

	validates :permalink, uniqueness: true
end