class ChangeProductsTable < ActiveRecord::Migration[5.0]
  def change
    remove_column :products, :price, :integer
    add_column :products, :condition, :integer
  end
end
