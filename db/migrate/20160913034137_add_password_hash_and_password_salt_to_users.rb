class AddPasswordHashAndPasswordSaltToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :password_hash, :string
    add_column :users, :password_salt, :string
  end
end
