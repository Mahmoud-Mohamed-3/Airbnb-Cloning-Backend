class AddFirstNameToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :first_name, :string, null: false
  end
end
