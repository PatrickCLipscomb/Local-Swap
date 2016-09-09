class Product < ActiveRecord::Base
  belongs_to :category
  has_many :reviews
  def previous
    self.category.products.where("products.id < ?", self.id).order('created_at asc').last
  end
  def next 
    self.category.products.where("products.id > ?", self.id).order('created_at asc').first
  end
end
