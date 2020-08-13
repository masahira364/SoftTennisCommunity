class TeamsController < ApplicationController
  def index
    @pref = JpPrefecture::Prefecture.find(params[:prefecture_code])
  	@teams = Team.all
    @prefecture = params[:prefecture_code]
    @prefecture_teams = Team.where(prefecture_code: @prefecture)
  end

  def show
  	@team = Team.find(params[:id])
    @user = User.find_by(id: current_user.id)
  end

  def new
  	@team = Team.new
  end

  def create
  	@team = Team.new(team_params)
    @user = current_user
    @user.team_id = @team.id
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

  def map
    @team = Team.find(params[:id])
  end

  def team_search
  end

  def bookmarks
    @teams = current_user.bookmark_teams
  end

  private
  def team_params
  	params.require(:team).permit(
                   :name,
                   :image,
  								 :slogan,
                   :postcode,
                   :prefecture_name,
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
