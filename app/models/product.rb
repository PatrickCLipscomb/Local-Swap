class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "100x100#", :large => "500x500>" }, :default_url => "/images/:style/missing_product.png", :processors => [:cropper]
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
  validates :name, :presence => true
  validates :category_id, :presence => true
  validates :condition, :presence => true

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

  def condition_text(int)
    condition_text_array = ["Basically Broken", "Worn", "Lightly Used", "Great", "Like New"]
    return condition_text_array[int]
  end

  def zig_zag(array)
    sorted = array.sort
    output = []
    while sorted.length > 0 do
      output.push(sorted[-1])
      sorted.pop
      if sorted.length > 0
        output.push(sorted[0])
        sorted.shift
      end
    end
    puts output
  end

  def odd_ball(array)
    oddBall = nil
    tempArray = array
    while tempArray.length > 0 do
      if tempArray[0] == tempArray[1]
        tempArray.shift
        tempArray.shift
      else
        oddBall = tempArray[0]
        tempArray = []
      end
    end
    puts oddBall
  end

end
