class Product < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300#", :thumb => "100x100#", :large => "1000x1000>" }, :default_url => "/images/:style/missing_product.png", :processors => [:cropper]
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

  def self.name_search(query)
    if query.present?
      category_name = Category.where("name @@ :q", q: query)
      if category_name.any?
        category_name
      else
        rank = <<-RANK
          ts_rank(to_tsvector(name), plainto_tsquery(#{sanitize(query)})) +
          ts_rank(to_tsvector(description), plainto_tsquery(#{sanitize(query)}))
        RANK
        where("name @@ :q or description @@ :q", q: query).order(rank.to_s + ' desc')
      end
    end

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

  def binary_counter(s)
    s_array = s.split('')
    o_count = 0
    o_holder = 0
    while s_array.length != 0
        if s_array[0] == '0'
            if s_array[1] == '1'
                o_count += 1
                s_array.shift
                s_array.shift
            else
              counter = 1
              while s_array[counter] == '0'
                counter += 1
              end
              o_holder = counter
              second_counter = counter + 1
              to_add = 0
              while counter != 0 && s_array[second_counter] == '1'
                counter -= 1
                second_counter += 1
                o_count += 1
              end
              counter.times do
                s_array.shift
              end
            end
        elsif s_array[0] == '1'
            if s_array[1] == '0'
                o_count += 1
                s_array.shift
                s_array.shift
            else
              counter = 1
              while s_array[counter] == '1'
                counter += 1
              end
              o_holder = counter
              second_counter = counter + 1
              to_add = 0
              while counter != 0 && s_array[second_counter] == '0'
                counter -= 1
                second_counter += 1
                o_count += 1
              end
              counter.times do
                s_array.shift
              end
            end
        end
    end
    puts o_count
  end

end
