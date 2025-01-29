class AlterContentInReviews < ActiveRecord::Migration[8.0]
  def change
    change_column :reviews, :content, :text , null: false
  end
end
