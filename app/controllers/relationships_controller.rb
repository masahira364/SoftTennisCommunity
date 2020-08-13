class RelationshipsController < ApplicationController

	def create
		current_user.team.follow(params[:team_id])
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
