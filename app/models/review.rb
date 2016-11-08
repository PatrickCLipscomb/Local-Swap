class Review < ActiveRecord::Base
  belongs_to :user
  has_many :users
  validates :content, :presence => true
  validates :rating, :presence => true
end
