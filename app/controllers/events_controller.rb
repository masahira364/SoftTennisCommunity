class EventsController < ApplicationController

	def index
		@team = Team.find_by(id: params[:team_id])
    	@events = Event.where(team_id: params[:team_id])
    	@event = Event.new
  	end

	def show
		@event = Event.find(params[:id])
	end

	def new
		@team = Team.find_by(id: params[:team_id])
		@event = Event.new
	end

	def create
		@team = Team.find_by(id: params[:team_id])
		@event = Event.new(event_params)
	    if @event.save
	       @event.create_notification_event(current_user)
	       redirect_to events_path(team_id: params[:event][:team_id])
	    else
	       render :new
	    end
	end

	def edit
		@event = Event.find(params[:id])
	end

	def update
		@event = Event.find(params[:id])
    	if @event.update(event_params)
    	   redirect_to events_path(team_id: @event.team_id)
    	else
    		render :edit
    	end
	end

	def destroy
		@team = Team.find_by(id: params[:team_id])
		@event = Event.find(params[:id])
		if @event.destroy
		   redirect_to events_path(team_id: @event.team_id)
		end
	end

	private
	def event_params
		params.require(:event).permit(:title, :description, :start_date, :end_date, :team_id)
	end

end
