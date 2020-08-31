module NotificationsHelper
  def unchecked_notifications
  	if current_user.team_id.present?
	    @notifications = current_user.team.passive_team_notifications.where(checked: false, action: "team").
	     				 or(current_user.team.passive_team_notifications.where(checked: false, action: "withdrawal")).
	     				 or(current_user.team.passive_team_notifications.where(checked: false, action: "article")).
	     				 or(current_user.team.passive_team_notifications.where(checked: false, action: "event")).
	     				 or(current_user.passive_notifications.where(checked: false)).
	     				 where.not(visitor_id: current_user.id)
	else
		@notifications = current_user.passive_notifications.where(checked: false)
	end
  end
end
