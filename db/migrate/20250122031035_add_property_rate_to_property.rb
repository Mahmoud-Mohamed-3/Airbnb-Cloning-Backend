class AddPropertyRateToProperty < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :property_rate, :float
  end
end
