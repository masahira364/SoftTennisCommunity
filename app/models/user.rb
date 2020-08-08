class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :bookmarks
  has_many :comments
  belongs_to :team, optional: true

  attachment :profile_image

  enum sex: {"男性": 0, "女性": 1}
end
