class Approval < ApplicationRecord

	belongs_to :user
	belongs_to :team

	# 通知機能
	def create_notification_approval(current_user)
		notification = current_user.active_notifications.new(
			approval_id: id,
			event_id: event_id,
			team_visited_id: team_id,
			action: 'approval'
				)
		notification.save if notification.valid?
	end
end
