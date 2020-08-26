class CalendarController < ApplicationController
  def calendar
    @team = Team.find_by(id: params[:team_id])
    @events = @team.events
  end
end
