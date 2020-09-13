class Event < ApplicationRecord
  belongs_to :team
  has_many :entries
  has_many :entry_users, through: :entries, source: :user
  has_many :notifications, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validate :end_date_before_start_date

  # 参加
  def entry_by?(user)
    entries.where(user_id: user.id).exists?
  end

  def end_date_before_start_date
    errors.add(:end_date, "は開始日時以降にしてください") if end_date < start_date
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
