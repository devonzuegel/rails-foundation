class CrunchbaseScraper < ActiveRecord::Base


	def initialize
		@companies, @investors = [], []

		url = 'http://static.crunchbase.com/daily/content_web.html'
		page = Nokogiri::HTML(open(url))
		rounds_table = page.css('table:contains("Featured Funding Rounds") table table tbody')[0].css('table tbody')

		for company_table in rounds_table
			@investors += parse_investors(company_table)
			@companies += [parse_company(company_table)].select { |c| c != '' }
		end
		ap @companies
	end


	def save_to_db
		Company.create(@companies)
		Investor.create(@investors)
	end
	

	private 
		def cb_permalink(a)
			a['href'].scan(/[\w-]+$/)[0] if a != nil
		end


		def parse_investors(company_table)
			investors = []

			invest_table = company_table.css('table tbody td:contains("Investors")')
			for i in invest_table.css('a')
				# Ignore any rows that are "+ x more investors".
				if not i.text =~ /\+ \d more investors/
					investors.push({ 
						name: i.text,
						permalink: cb_permalink(i)
					})
				end
			end
			return investors
		end


		def parse_company(company_table)
			h2 = company_table.search('h2')
			return '' if h2.text == ''  # Skip if company_table contains no name
			
			return {
				permalink: cb_permalink(h2.css('a[href]')[0]),
				name: h2.text, 
			}
		end


end
