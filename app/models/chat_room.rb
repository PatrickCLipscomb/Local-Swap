class ChatRoom < ApplicationRecord
  belongs_to :user
  has_many :chat_messages, dependent: :destroy
  validates :title, presence: true, uniqueness: true, case_sensitive: false
end
