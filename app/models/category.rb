class Category < ActiveRecord::Base
  has_many :products
  validates :name, :presence => true
  after_create :create_chat_room
  has_attached_file :image, :styles => { :medium => "200x200>", :thumb => "100x100#" }, :default_url => "/images/:style/missing_category.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  def create_chat_room
    current_user = User.find_by(user_name: 'Admin')
    if current_user
      current_user.chat_rooms.create(title: self.name)
    end
  end
end
