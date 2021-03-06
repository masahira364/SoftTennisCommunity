class TeamsController < ApplicationController
  before_action :set_team, only: [
    :show, :edit, :update, :map, :calendar,
    :member, :matching, :approvals,
  ]

  def index
    @q = Team.ransack(params[:q])
    @teams = @q.result(distinct: true)
    @pref = params[:prefecture_code]
    @prefecture = JpPrefecture::Prefecture.find(@pref)
    @prefecture_teams = Team.where(prefecture_code: @pref)
    if params[:q]
      @search_prefecture = JpPrefecture::Prefecture.
                           find(params[:q][:prefecture_code_eq].to_i)
    end
  end

  def show
    @user = current_user
    unless @user.team_id.nil?
      @current_team = Team.find(@user.team_id)
    end
  end

  def new
    @team = Team.new
  end

  def create
    @team = Team.new(team_params)
    @user = current_user
    if @team.save
      @user.update(team_id: @team.id)
      redirect_to teams_path, notice: "#{@team.name}を立ち上げました"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @team.update(team_params)
      redirect_to team_path(@team), notice: "チームの情報を更新しました"
    else
      render :edit
    end
  end

  def calendar
    @events = @team.events
  end

  def map
  end

  def member
  end

  def approvals
    @approvals = Approval.where(team_id: @team.id)
    @event_approvals = Approval.where(team_id: @team.id, action: 'entry')
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def search_params
    params.require(:q).permit(:name_cont, :address_cont, :prefecture_code_eq, :number_of_people_gteq)
  end

  def team_params
    params.require(:team).permit(
      :name,
      :image,
      :slogan,
      :postal_code,
      :prefecture_code,
      :address,
      :practice_day,
      :number_of_people,
      :annual_fee,
      :entry_fee,
      :members_wanted,
      :recruitment_targrt,
      :introduction,
      :facebook,
      :twitter,
      :instagram,
      :homepage_url,
      :email
    )
  end
end
