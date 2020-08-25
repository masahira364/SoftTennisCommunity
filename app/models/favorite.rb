class Favorite < ApplicationRecord
	belongs_to :user
	belongs_to :article

	# 通知機能
	def create_notification_favorite(current_user)
		# すでにいいねされているか検索
		temp = Notification.where(["visitor_id = ? and team_visited_id = ? and article_id = ? 
									and favorite_id = ? and action = ? ", 
									current_user.id, self.article.team_id, self.article_id,
									id, 'favorite'])
		# いいねされていなければ通知作成
		if temp.blank?
			notification = current_user.active_notifications.new(
				article_id: self.article_id,
				favorite_id: id,
				team_visited_id: self.article.team_id,
				action: 'favorite'
				)
			# 自分で自分の投稿にいいねした際は通知済にする
			if notification.visitor_id == notification.visited_id
				notification.checked = true
			end
			notification.save if notification.valid?
		end
	end
end
