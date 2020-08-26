class ApprovalsController < ApplicationController
  def create
    if params[:approval][:event_id] = nil
      approval = current_user.approvals.build(team_id: params[:team_id], event_id: params[:approval][:event_id], action: params[:approval][:action])
    else
      approval = current_user.approvals.build(team_id: params[:team_id])
    end
    approval.save!
    approval.create_notification_approval(current_user)
    redirect_to request.referer
  end

  def destroy
    if params[:approval]
      Approval.find_by(user_id: current_user.id, event_id: params[:approval][:event_id]).destroy!
    else
      Approval.find(params[:id]).destroy!
    end
    redirect_to request.referer
  end
end
