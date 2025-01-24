class DropReservationsTable < ActiveRecord::Migration[8.0]
  def change
    drop_table :reservations
  end
end
