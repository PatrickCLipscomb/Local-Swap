class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  geocoded_by :address
  before_create :geocode
  after_create :send_welcome_message
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def send_welcome_message
    UserMailer.signup_confirmation(self).deliver
  end
  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" }, :default_url => "/images/:style/missing.jpeg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates :user_name, :presence => true
  validates :address, :presence => true
  has_many :products
  has_many :reviews
  # def recent_prods
  #   users = []
  #   Products.all.order('id desc').each do |product|
  #     users.push(product.user)
  #   end
  #   users
  # end
  acts_as_messageable
  def name
    return user_name
  end
  # Used for the automated email that mailboxer sends with each message that is created
  def mailboxer_email(object)
    return email
  end
end
