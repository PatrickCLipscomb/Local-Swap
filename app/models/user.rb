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
  acts_as_messageable

  def name
    return user_name
  end
  # Used for the automated email that mailboxer sends with each message that is created
  def mailboxer_email(object)
    return email
  end

  def ratings
    if self.reviews.any?
      avg_rating = 0
      self.reviews.each do |review|
        avg_rating += review.rating
      end
      avg_rating = (avg_rating/self.reviews.length).ceil
      return avg_rating
    end
  end
end
