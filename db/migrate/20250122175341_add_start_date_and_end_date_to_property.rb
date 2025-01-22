class AddStartDateAndEndDateToProperty < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :start_date, :datetime
    add_column :properties, :end_date, :datetime
  end
end
