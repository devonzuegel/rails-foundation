class StaticController < ApplicationController

	def index
		crunchbase_scrape = CrunchbaseScraper.new()
		@companies = crunchbase_scrape.companies
		@investors = crunchbase_scrape.investors	
	end

end