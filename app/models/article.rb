class Article < ApplicationRecord

	belongs_to :team
	has_many :favorites
	has_many :comments, dependent: :destroy

	attachment :image
end
