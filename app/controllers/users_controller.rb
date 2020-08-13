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
       if @user.update(params[:user][:team_id])
          redirect_to team_path(params[:user][:team_id])
       else
  	      redirect_to user_path(@user)
       end
    else
      render :edit
    end
  end

  def bookmarks
    @user = current_user
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
  	 	:introduction)
  end
end
