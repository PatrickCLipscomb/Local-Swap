class Review < ActiveRecord::Base
  belongs_to :product
  belongs_to :user
  validates :name, :presence => true
  validates :content, :presence => true
  validates :rating, :presence => true
end
