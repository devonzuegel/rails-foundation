class CreateInvestments < ActiveRecord::Migration
  def change
    create_table :investments do |t|
      t.belongs_to :company, index: true
      t.belongs_to :investor, index: true

      t.timestamps null: false
    end
    add_foreign_key :investments, :companies
    add_foreign_key :investments, :investors
  end
end
