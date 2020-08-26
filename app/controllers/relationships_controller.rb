class RelationshipsController < ApplicationController
  def create
    @team = Team.find(params[:team_id])
    current_user.team.follow(params[:team_id])
    @team.create_notification_follow(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.team.unfollow(params[:team_id])
    redirect_to request.referer
  end

  def matching
    @team = Team.find_by(id: params[:team_id])
    @teams = @team.matchers
    end
end
