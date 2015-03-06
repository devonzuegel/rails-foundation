class AddPermalinkToCompaniesAndInvestors < ActiveRecord::Migration
  def change
  	add_column :companies, :permalink, :string
  	add_column :investors, :permalink, :string
  end
end
