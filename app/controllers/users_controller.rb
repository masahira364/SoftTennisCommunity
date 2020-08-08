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
  	   redirect_to user_path(@user)
  	else
  		render :edit
  	end
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