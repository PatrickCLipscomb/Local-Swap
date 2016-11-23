class CreateSecondmodels < ActiveRecord::Migration[5.0]
  def change
    create_table :secondmodels do |t|
      t.string :name
      t.integer :firstmodel_id

      t.timestamps
    end
  end
end
