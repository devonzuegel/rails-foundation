class CrunchbaseScraper < ActiveRecord::Base

	def initialize
		@companies, @investors, @investments = [], [], []

		url = 'http://static.crunchbase.com/daily/content_web.html'
		page = Nokogiri::HTML(open(url))
		rounds_table = page.css('table:contains("Featured Funding Rounds") table table tbody')[0].css('table tbody')

		for company_table in rounds_table
			company = parse_company(company_table)
			
			if company != ""
				@investors += parse_investors(company_table)
				@companies += [company].select { |c| c != '' }
			
				@investors.each do |i|
					@investments.push({
						investor: i[:permalink],
						company:  company[:permalink]
					})
				end
			end
		end
	end


	def save_to_db
		Company.create(@companies)
		Investor.create(@investors)

		investments = []
		@investments.each do |i|
			investments.push({
				investor_id: Investor.where(permalink: i[:investor])[0][:id],
				company_id:  Company.where(permalink:  i[:company])[0][:id],
			})
		end
		Investment.create(investments)
	end
	

	private  #------------------------
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
