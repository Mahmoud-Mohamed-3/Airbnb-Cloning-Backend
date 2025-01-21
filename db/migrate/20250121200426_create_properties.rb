class CreateProperties < ActiveRecord::Migration[8.0]
  def change
    create_table :properties do |t|
      t.string :title
      t.text :description
      t.references :user, null: false, foreign_key: true
      t.string :owner

      t.timestamps
    end
  end
end
