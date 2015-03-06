namespace :scrape do

	desc "Scraping today's data from Crunchbase Daily"
	task :crunchbase => :environment do
		cb = CrunchbaseScraper.new
		puts Investment.count
		cb.save_to_db
		puts Investment.count
	end

end