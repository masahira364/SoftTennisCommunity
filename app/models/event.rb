class Event < ApplicationRecord
  belongs_to :team
  has_many :entries
  has_many :entry_users, through: :entries, source: :user
  has_many :notifications, dependent: :destroy

  # 参加
  def entry_by?(user)
    entries.where(user_id: user.id).exists?
  end

  # 通知機能
  def create_notification_event(current_user)
    notification = current_user.active_notifications.new(
      event_id: id,
      team_visited_id: team_id,
      action: 'event'
    )
    notification.save if notification.valid?
  end
end
