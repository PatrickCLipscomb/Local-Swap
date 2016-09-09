class DropFirstmodelsTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :firstmodels
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
