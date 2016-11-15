class Category < ActiveRecord::Base
  has_many :products
  has_and_belongs_to_many :users
  validates :name, :presence => true
  has_attached_file :image, :styles => { :medium => "200x200>", :thumb => "100x100#" }, :default_url => "/images/:style/missing_category.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
