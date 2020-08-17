class Team < ApplicationRecord

	has_many :users, dependent: :destroy
	has_many :bookmarks, dependent: :destroy
	has_many :articles, dependent: :destroy
	has_many :events, dependent: :destroy

	attachment :image

	# 住所自動入力
	include JpPrefecture
	jp_prefecture :prefecture_code, method_name: :pref

	def prefecture_name
	  JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
	end

	def prefecture_name=(prefecture_name)
	  self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
	end

	# geocoder
	geocoded_by :address
	after_validation :geocode

	# チームフォローの記述
	has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
	has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
	has_many :following_team, through: :follower, source: :followed
	has_many :follower_team, through: :followed, source: :follower

	def follow(team_id)
		follower.create(followed_id: team_id)
	end

	def unfollow(team_id)
		follower.find_by(followed_id: team_id).destroy
	end

	def following?(team)
		following_team.include?(team)
	end

	def matchers
		Team.where(id: follower.select(:followed_id))
		.where(id: followed.select(:follower_id))
	end

	# ブックマーク
	def bookmark_by?(user)
		bookmarks.where(user_id: user.id).exists?
	end
end
