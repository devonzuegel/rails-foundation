namespace :scrape do

	desc "Scraping today's data from Crunchbase Daily"
	task :crunchbase => :environment do
		cb = CrunchbaseScraper.new
		cb.save_to_db
	end

end