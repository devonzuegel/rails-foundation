module Scopable
  extend ActiveSupport::Concern
  
  included do
		scope :today, -> { where("created_at >= ? ", Time.zone.now.beginning_of_day) }
  end
  
end