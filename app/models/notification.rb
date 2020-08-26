class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :article, optional: true
  belongs_to :comment, optional: true
  belongs_to :event, optional: true

  belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true

  belongs_to :team_visitor, class_name: 'Team', foreign_key: 'team_visitor_id', optional: true
  belongs_to :team_visited, class_name: 'Team', foreign_key: 'team_visited_id', optional: true
end
