class Team < ApplicationRecord

	has_many :users
	has_many :bookmarks
	has_many :articles
	has_many :events
	belongs_to :prefecture, optional: true

	attachment :image

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

	private
	def geocode
		uri = URI.escape("https://maps.googleapis.com/maps/api/geocode/json?address="+self.address.gsub(" ", "")+"&key=#{ENV['SECRET_KEY']}")
end
