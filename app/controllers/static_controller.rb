class StaticController < ApplicationController

	def index
		@companies = Company.today
		@investors = Investor.today
		
		gon.companies = @companies
	end

end