class RemoveTitleFromProperties < ActiveRecord::Migration[8.0]
  def change
    remove_column :properties, :title, :string
  end
end
