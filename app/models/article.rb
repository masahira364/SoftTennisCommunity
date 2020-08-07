class Article < ApplicationRecord

	belongs_to :team
	has_many :comments
end
