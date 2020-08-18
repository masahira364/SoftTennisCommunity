class Article < ApplicationRecord

	belongs_to :team
	has_many :favorites
	has_many :comments, dependent: :destroy

	attachment :image

	acts_as_taggable

	# いいね
	def favorite_by?(user)
		favorites.where(user_id: user.id).exists?
	end
end
