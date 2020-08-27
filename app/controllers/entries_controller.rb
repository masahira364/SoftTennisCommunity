class EntriesController < ApplicationController
  def create
    entry = current_user.entries.build(event_id: params[:event_id])
    entry.save!
    # 承認申請を削除
    if params[:team_id].present?
      approval = Approval.find_by(team_id: params[:team_id], user_id: params[:user_id],
                                  event_id: params[:event_id])
      approval.destroy
    end
    entry.create_notification_entry(current_user)
    redirect_to request.referer, notice: "予定に参加しました"
  end

  def destroy
    entry = current_user.entries.find_by(event_id: params[:event_id])
    entry.destroy!
    redirect_to request.referer, alert: "予定への参加をキャンセルしました"
  end
end
