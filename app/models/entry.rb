class Entry < ApplicationRecord
	belongs_to :user
	belongs_to :event

	# 通知機能
	def create_notification_entry(current_user)
		# すでに参加しているか検索
		temp = Notification.where(["visitor_id = ? and team_visited_id = ? and event_id = ? 
									and entry_id = ? and action = ?", 
									current_user.id, self.event.team_id, self.event_id,
									 id, 'entry'
									])
		# 参加していなければ通知作成
		if temp.blank?
			notification = current_user.active_notifications.new(
				event_id: self.event_id,
				entry_id: id,
				team_visited_id: self.event.team_id,
				action: 'entry'
				)
			# 自分で自分の予定に参加した際は通知済にする
			if notification.visitor_id == notification.visited_id
				notification.checked = true
			end
			notification.save if notification.valid?
		end
	end
end
