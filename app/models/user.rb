class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  geocoded_by :address
  after_validation :geocode, :if => :address_changed?
  after_create :send_welcome_message
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def send_welcome_message
    UserMailer.signup_confirmation(self).deliver
  end
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.jpeg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  has_many :products
  has_many :reviews
end
