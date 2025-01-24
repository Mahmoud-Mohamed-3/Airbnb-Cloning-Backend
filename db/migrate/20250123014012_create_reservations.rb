# db/migrate/YYYYMMDDHHMMSS_create_reservations.rb
class CreateReservations < ActiveRecord::Migration[8.0]
  def change
    create_table :reservations do |t|
      t.bigint :user_id, null: false
      t.bigint :property_id, null: false
      t.string :status, default: 'pending'
      t.timestamps
    end

    add_foreign_key :reservations, :users, column: :user_id
    add_foreign_key :reservations, :properties, column: :property_id
  end
end
