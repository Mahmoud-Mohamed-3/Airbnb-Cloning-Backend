class AddValueRatingAndCommunicationRatingAndLocationRating < ActiveRecord::Migration[8.0]
  def change
    add_column :reviews, :value_rating, :integer, null: false
    add_column :reviews, :communication_rating, :integer, null: false
    add_column :reviews, :location_rating, :integer, null: false
  end
end
