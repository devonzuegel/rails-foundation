class CreateCrunchbaseScrapers < ActiveRecord::Migration
  def change
    create_table :crunchbase_scrapers do |t|

      t.timestamps null: false
    end
  end
end
