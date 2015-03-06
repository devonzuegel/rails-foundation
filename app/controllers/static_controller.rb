class StaticController < ApplicationController

	def index
		@companies = Company.today
		@investors = Investor.today
	end

end