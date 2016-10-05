class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing_product.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :name, :presence => true
  validates :category_id, :presence => true
  validates :price, :presence => true


  def previous
    self.category.products.where("products.id < ?", self.id).order('created_at asc').last
  end
  def next
    self.category.products.where("products.id > ?", self.id).order('created_at asc').first
  end
end
