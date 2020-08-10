class EventsController < ApplicationController

	def show
		@event = Event.find(params[:id])
	end

	def new
		@event = Event.new
	end

	def create
		@event = Event.new(event_params)
		if @event.save
		   redirect_to calendar_team_path(@event.team_id)
		else
			render :new
		end
	end

	def destroy
		@team = Team.find_by(id: params[:team_id])
		@event = Event.find(params[:id])
		if @event.destroy
		   redirect_to calendar_team_path(@event.team_id)
		end
	end

	private
	def event_params
		params.require(:event).permit(:title, :description, :start_date, :end_date, :team_id)
	end

end
