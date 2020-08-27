class ApprovalsController < ApplicationController
  def create
    @event_id = params[:approval][:event_id]
    unless params[:approval][:event_id] = nil
      approval = current_user.approvals.build(team_id: params[:team_id], 
                                              event_id: @event_id)
      notification = Notification.new(visitor_id: current_user.id, team_visited_id: params[:team_id],
                                        event_id: @event_id, action: 'approval')
      notification.save!
    else
      approval = current_user.approvals.build(team_id: params[:team_id])
      approval.create_notification_approval(current_user)
    end
    approval.save!
    redirect_to request.referer, notice: "チーム参加の申請をしました"
  end

  def destroy
    if params[:approval]
      Approval.find_by(user_id: current_user.id, event_id: params[:approval][:event_id]).destroy!
    else
      Approval.find(params[:id]).destroy!
    end
    redirect_to request.referer, alert: "チーム参加の申請を取り消しました"
  end
end
