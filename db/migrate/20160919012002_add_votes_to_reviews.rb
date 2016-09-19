class AddVotesToReviews < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :votes, :integer, default: '0'
    add_column :reviews, :has_voted, :integer, array: true, default: []
  end
end
