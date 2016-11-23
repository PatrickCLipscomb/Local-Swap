class CreateThirdmodels < ActiveRecord::Migration[5.0]
  def change
    create_table :thirdmodels do |t|
      t.string :name
      t.integer :secondmodel_id

      t.timestamps
    end
  end
end
