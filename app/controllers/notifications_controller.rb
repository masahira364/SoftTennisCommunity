class NotificationsController < ApplicationController

	def index
		if params[:team_id]
			@team = Team.find(params[:team_id])
			@team_notifications = Notification.where(team_visited_id: @team.id)
							  .page(params[:page]).per(20)
		else
			@notifications = Notification.where(visited_id: current_user.id)
							.or(Notification.where(team_visited_id: current_user.team_id))
							.page(params[:page]).per(20)
		end
	end
end
