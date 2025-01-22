class CreateReviews < ActiveRecord::Migration[8.0]
  def change
    create_table :reviews do |t|
      t.string :content, null: false
      t.integer :cleanliness_rating, null: false
      t.integer :accurancy_rating, null: false
      t.integer :check_in_rating, null: false
      t.integer :final_rating, null: false
      t.references :user, null: false, foreign_key: true
      t.references :property, null: false, foreign_key: true

      t.timestamps
    end
  end
end
