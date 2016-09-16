class AddUserIdToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :user_id, :integer
    remove_column :categories, :user_id, :interger
  end
end
