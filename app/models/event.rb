class Event < ApplicationRecord

	belongs_to :team
	has_many :entries

	# 参加
	def entry_by?(user)
		entries.where(user_id: user.id).exists?
	end
end
