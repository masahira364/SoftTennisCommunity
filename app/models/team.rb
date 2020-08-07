class Team < ApplicationRecord

	has_many :bookmarks
	has_many :articles
	belongs_to :prefecture

	has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :delete
	has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :delete
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
end
