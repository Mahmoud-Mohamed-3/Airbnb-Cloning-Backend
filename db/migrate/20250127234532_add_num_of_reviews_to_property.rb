class AddNumOfReviewsToProperty < ActiveRecord::Migration[8.0]
  def change
    add_column :properties, :num_of_reviews, :integer, default: 0
  end
end
