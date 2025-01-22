class AddCityAndCountryAndPriceAndDurationToProperties < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :city, :string, null: false
    add_column :properties, :country, :string, null: false
    add_column :properties, :price, :string, null: false
    add_column :properties, :duration, :string, null: false
  end
end
