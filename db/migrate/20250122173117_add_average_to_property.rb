class AddAverageToProperty < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :ave_cleanliness, :float, null: false, default: 0
    add_column :properties, :ave_accurancy, :float, null: false, default: 0
    add_column :properties, :ave_check_in, :float, null: false, default: 0
    add_column :properties, :ave_value, :float, null: false, default: 0
    add_column :properties, :ave_communication, :float,  null: false, default: 0
    add_column :properties, :ave_location, :float, null: false, default: 0
  end
end
