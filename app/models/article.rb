class Article < ApplicationRecord
  belongs_to :team
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :notifications, dependent: :destroy

  attachment :image

  acts_as_taggable

  # いいね
  def favorite_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  # 通知機能
  def create_notification_article(current_user)
    notification = current_user.active_notifications.new(
      article_id: id,
      team_visited_id: team_id,
      action: 'article'
    )
    notification.save if notification.valid?
  end
end
