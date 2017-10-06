class User < ApplicationRecord
  validates :user_name, presence:true, length: { minimum: 4, maximum: 16 }
  has_attached_file :avatar, styles: { medium: '200x200#' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  has_many :posts, dependent: :destroy
  has_many :commments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
