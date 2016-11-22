class DropThirdmodelsTable < ActiveRecord::Migration[5.0]
  def up
    drop_table :thirdmodels
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
