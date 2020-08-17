class Event < ApplicationRecord

	belongs_to :team
	has_many :entries
end
