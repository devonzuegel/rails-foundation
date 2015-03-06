class CrunchbaseScraper < ActiveRecord::Base


	def initialize
		url = 'http://static.crunchbase.com/daily/content_web.html'
		page = Nokogiri::HTML(open(url))

		rounds_table = page.css('table:contains("Featured Funding Rounds") table table tbody')[0].css('table tbody')
		companies, investors = {} , {}
		for company_table in rounds_table
			investors_hash = parse_investors(company_table)
			company = parse_company(company_table, investors_hash)

			investors = investors.merge(investors_hash)
			companies = companies.merge(company) if company != nil
		end
		companies = companies.select { |c| c != nil }

		@companies = companies
		@investors = investors
	end


	def companies
		@companies
	end


	def investors
		@investors
	end
	

	private 
		def cb_permalink(a)
			a['href'].scan(/[\w-]+$/)[0] if a != nil
		end


		def parse_investors(company_table)
			investors = {}

			invest_table = company_table.css('table tbody td:contains("Investors")')
			for i in invest_table.css('a')
				# Ignore any rows that are "+ x more investors".
				if not i.text =~ /\+ \d more investors/
					investors[cb_permalink(i)] = { name: i.text }
				end
			end
			return investors
		end


		def parse_company(company_table, investors)
			h2 = company_table.search('h2')
			return nil if h2.text == ''  # Skip if company_table contains no name
			
			company = { 
				name: h2.text, 
				investors: investors.keys
			}

			permalink = cb_permalink(h2.css('a[href]')[0])
			return { "#{permalink}" => company }
		end


end
