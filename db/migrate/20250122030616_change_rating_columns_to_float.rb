class ChangeRatingColumnsToFloat < ActiveRecord::Migration[8.0]
  def change
    change_column :reviews, :cleanliness_rating, :float
    change_column :reviews, :accurancy_rating, :float
    change_column :reviews, :check_in_rating, :float
    change_column :reviews, :value_rating, :float
    change_column :reviews, :communication_rating, :float
    change_column :reviews, :location_rating, :float
    change_column :reviews, :final_rating, :float
  end
end
