class AddAuthorToReviews < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :product_id, :integer
    add_column :reviews, :author_id, :integer
  end
end
