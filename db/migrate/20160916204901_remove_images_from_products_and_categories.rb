class RemoveImagesFromProductsAndCategories < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :image, :string
    remove_column :categories, :image, :string
  end
end
