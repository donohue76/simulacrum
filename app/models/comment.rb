class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true

  validates :content, length: { minimum: 3, maximum: 300 }
end
