class NotificationsController < ApplicationController
  def index
    # チームの通知一覧
    if params[:team_id]
       @team = Team.find(params[:team_id])
       @team_notifications = Notification.where(team_visited_id: @team.id).
                             page(params[:page]).per(20)
    else
      # 個人の通知一覧
      @notifications = Notification.where(visited_id: current_user.id).
                       or(Notification.where(team_visited_id: current_user.team_id, action: "team")).
                       or(Notification.where(team_visited_id: current_user.team_id, action: "withdrawal")).
                       or(Notification.where(team_visited_id: current_user.team_id, action: "article")).
                       or(Notification.where(team_visited_id: current_user.team_id, action: "event")).
                       where.not(visitor_id: current_user.id).
                       page(params[:page]).per(20)
      @notifications.where(checked: false).each do |notification|
        notification.update_attributes(checked: true)
      end
    end
  end
end
