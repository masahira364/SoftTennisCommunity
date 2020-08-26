class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "Team"
  belongs_to :followed, class_name: "Team"
end
