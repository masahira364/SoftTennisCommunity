class Article < ApplicationRecord

	belongs_to :team
	has_many :comments

	attachment :image
end
