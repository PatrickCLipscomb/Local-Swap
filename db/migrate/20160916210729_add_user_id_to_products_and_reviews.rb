class AddUserIdToProductsAndReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :user_id, :integer
    add_column :categories, :user_id, :integer
  end
end
