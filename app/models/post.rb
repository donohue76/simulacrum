class Post < ApplicationRecord
	validates :user_id, presence: true

	belongs_to :user
	has_many :posts, dependent: :destroy

	validates :image, presence: true

	has_attached_file :image, styles: { :medium => "640" }

	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\z/

end
