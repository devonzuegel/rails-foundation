# require 'htmlentities'
# require 'mechanize'

# a = Mechanize.new { |agent| agent.user_agent_alias = 'Mac Safari' }


# page = a.get(url).parser
# puts page



require 'rubygems'
require 'nokogiri' 
require 'open-uri'

URL = 'http://static.crunchbase.com/daily/content_web.html'
page = Nokogiri::HTML(open(URL))

featured = page.css('table:contains("Featured Funding Rounds") table table tbody')[0]

for c in featured.css('table tbody')
	puts c.search('h2').text
end