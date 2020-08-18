class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # 空白不可
  validates :nickname, presence: true
  validates :sex, presence: true
  validates :age, presence: true
  validates :postal_code, presence: true
  validates :prefecture_code, presence: true
  validates :address, presence: true


  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_teams, through: :bookmarks, source: :team
  has_many :entries
  has_many :entry_events, through: :entries, source: :event
  has_many :favorites
  has_many :favorite_articles, through: :favorites, source: :article
  has_many :comments, dependent: :destroy
  has_many :approvals, dependent: :destroy
  belongs_to :team, optional: true

  attachment :profile_image

  enum sex: {"男性": 0, "女性": 1}

  # 住所自動入力
	include JpPrefecture
	jp_prefecture :prefecture_code

	def prefecture_name
	  JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
	end

	def prefecture_name=(prefecture_name)
	  self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
	end
end
