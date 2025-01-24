class AddColumnsToProperty < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :type, :string, null: false
    add_column :properties, :place, :string, null: false
    add_column :properties, :max_guests, :integer, null: false
    add_column :properties, :bedrooms, :integer, null: false
    add_column :properties, :beds, :integer, null: false
    add_column :properties, :baths, :integer, null: false
  end
end
