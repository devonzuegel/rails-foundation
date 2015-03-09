class StaticController < ApplicationController

	def index
		gon.nodes = graph_nodes
		gon.links = graph_links(gon.nodes)
	end

	def about
	end

	private  # -----------------------------------------------
	def graph_nodes
		nodes = []
		Company.all.each do |c|
			nodes += [{ name: c.name, permalink: c.permalink, group: 1 }]
		end
		Investor.all.each do |i|
			nodes += [{ name: i.name, permalink: i.permalink, group: 2 }]
		end
		return nodes
	end

	def graph_links(nodes)
		links = []
		Investment.all.each do |investment|
			c_permalink = Company.find(investment.company_id)[:permalink]
			i_permalink = Investor.find(investment.investor_id)[:permalink]
			links += [{ 
				source: nodes.index(nodes.find {|n| n[:permalink] == i_permalink }),
				target: nodes.index(nodes.find {|n| n[:permalink] == c_permalink }),				
			}]
		end
		return links
	end
end