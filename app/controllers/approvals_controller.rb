class ApprovalsController < ApplicationController

	def create
		approval = current_user.approvals.build(team_id: params[:team_id])
		approval.save!
		approval.create_notification_approval(current_user)
		redirect_to request.referer
	end

	def destroy
		approval = Approval.find(params[:id]).destroy
		redirect_to request.referer
	end
end
