class AddStartdateAndEnddateToReservations < ActiveRecord::Migration[8.0]
  def change
    add_column :reservations, :start_date, :datetime
    add_column :reservations, :end_date, :datetime
    add_column :reservations, :total_price, :decimal, precision: 10, scale: 2
  end
end
