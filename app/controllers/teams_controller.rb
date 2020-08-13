class TeamsController < ApplicationController

  before_action :set_team, only: [:show, :edit, :update, :calendar, :map, :member, :matching]

  def index
    @q = Team.ransack(params[:q])
  	@teams = @q.result(distinct: true)
    @pref = params[:prefecture_code]
    @prefecture = JpPrefecture::Prefecture.find(params[:prefecture_code])
    @prefecture_teams = Team.where(prefecture_code: @prefecture)
    
  end

  def search
    @q = Team.search(search_params)
    @teams = @q.result(distinct: true)
    @prefecture = JpPrefecture::Prefecture
                  .find(params[:q][:prefecture_code_eq].to_i)
  end

  def show
    @user = User.find_by(id: current_user.id)
    @current_team = Team.find(@user.team_id)
    @man = @team.users.where(sex: "男性").count
    @woman = @team.users.where(sex: "女性").count
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
  end

  def update
  	if @team.update(team_params)
  	   redirect_to team_path(@team)
  	else
  		render :edit
  	end
  end

  def calendar
    @events = @team.events
  end

  def map
  end

  def team_search
  end

  def member
  end

  private
  def set_team
    @team = Team.find(params[:id])
  end

  def search_params
    params.require(:q).permit(:name_cont, :prefecture_code_eq, :number_of_people_gteq)
  end

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
