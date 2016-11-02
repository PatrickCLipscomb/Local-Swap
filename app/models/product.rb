class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100#", :large => "500x500>" }, :default_url => "/images/:style/missing_product.png", :processors => [:cropper]
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :name, :presence => true
  validates :category_id, :presence => true
  validates :price, :presence => true

  attr_accessor :crop_x, :crop_y, :crop_w, :crop_h

  def cropping?
    !crop_x.blank? && !crop_y.blank? && !crop_w.blank? && !crop_h.blank?
  end

  def image_geometry(style = :original)
    @geometry ||= {}
    @geometry[style] ||= Paperclip::Geometry.from_file(image.path(style))
  end

  def reprocess_image
    image.reprocess!
  end

  def previous
    self.category.products.where("products.id < ?", self.id).order('created_at asc').last
  end

  def next
    self.category.products.where("products.id > ?", self.id).order('created_at asc').first
  end
end
