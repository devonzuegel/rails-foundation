class Investment < ActiveRecord::Base
  include Scopable

  belongs_to :company
  belongs_to :investor

	validates_uniqueness_of :company, :scope => [:investor]

end