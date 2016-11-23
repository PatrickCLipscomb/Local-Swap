class AddImageFileToCategories < ActiveRecord::Migration[5.0]
  def self.up
    change_table :categories do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :categories, :image
  end
end
