class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    if @user.update(user_params)
      # プロフィール更新時
      if params[:user][:team_id] == nil
         redirect_to user_path(@user)
      # チーム参加承認時
      else
         @approval = Approval.find_by(team_id: params[:user][:team_id])
         @approval.destroy
         redirect_to request.referer
      end
    else
       render :edit
    end
  end

  def bookmarks
    @user = current_user
  end

  def favorites
    @user = current_user
    @articles = @user.favorite_articles
  end

  def entries
    @user = current_user
    @events = @user.entry_events
  end


  private
  def user_params
  	params.require(:user).permit(
  		:sex,
  	 	:nickname,
  	 	:email,
  	 	:profile_image,
  	 	:postal_code,
  	 	:address,
  	 	:position,
  	 	:racket,
  	 	:good_play,
  	 	:introduction,
      :team_id)
  end
end
