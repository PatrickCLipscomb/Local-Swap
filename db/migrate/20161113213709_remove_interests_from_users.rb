class RemoveInterestsFromUsers < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :interests, :integer, array: true
  end
end
