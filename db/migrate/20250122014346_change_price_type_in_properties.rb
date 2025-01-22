class ChangePriceTypeInProperties < ActiveRecord::Migration[8.0]
  def up
    # Add a new column with the desired type
    add_column :properties, :new_price, :decimal, precision: 10, scale: 2

    # Copy and convert data from the old column to the new column
    Property.reset_column_information
    Property.find_each do |property|
      property.update(new_price: property.price.to_f)
    end

    # Remove the old column
    remove_column :properties, :price

    # Rename the new column to the old column's name
    rename_column :properties, :new_price, :price
  end

  def down
    # Reverse the process if you need to rollback
    add_column :properties, :old_price, :string

    Property.reset_column_information
    Property.find_each do |property|
      property.update(old_price: property.price.to_s)
    end

    remove_column :properties, :price
    rename_column :properties, :old_price, :price
  end
end
