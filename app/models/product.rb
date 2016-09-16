class Product < ActiveRecord::Base
  belongs_to :category
  has_many :reviews
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing_product.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  def previous
    self.category.products.where("products.id < ?", self.id).order('created_at asc').last
  end
  def next
    self.category.products.where("products.id > ?", self.id).order('created_at asc').first
  end
end
