class TeamsController < ApplicationController
  def index
  	@teams = Team.all
  end

  def show
  	@team = Team.find(params[:id])
  end

  def new
  	@team = Team.new
  end

  def create
  	@team = Team.new(team_params)
  	if @team.save
  	   redirect_to teams_path
  	else
  	   render :new
  	end
  end

  def edit
  	@team = Team.find(params[:id])
  end

  def update
  	@team = Team.find(params[:id])
  	if @team.update(team_params)
  	   redirect_to team_path(@team)
  	else
  		render :edit
  	end
  end

  def calendar
    @team = Team.find(params[:id])
    @events = @team.events
  end

  private
  def team_params
  	params.require(:team).permit(:name,
  								 :slogan,
  								 :address,
  								 :practice_day,
  								 :number_of_people,
  								 :average_age,
  								 :annual_fee,
  								 :entry_fee,
  								 :members_wanted,
  								 :introduction,
  								 :homepage,
  								 :contact_infometion)
  end
end
