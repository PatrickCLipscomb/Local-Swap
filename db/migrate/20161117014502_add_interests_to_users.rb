class AddInterestsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :interests, :integer, array: true, default: []
  end
end
