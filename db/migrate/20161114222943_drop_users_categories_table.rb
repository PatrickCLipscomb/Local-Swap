class DropUsersCategoriesTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :users_categories
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
