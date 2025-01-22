class RemoveDurationFromProperty < ActiveRecord::Migration[8.0]
  def change
    remove_column :properties, :duration, :string
  end
end
