class FavoritesController < ApplicationController

	def create
		favorite = current_user.favorites.build(article_id: params[:article_id])
		favorite.save!
		redirect_to request.referer
	end

	def destroy
		current_user.favorites.find_by(article_id: params[:article_id]).destroy!
		redirect_to request.referer
	end
end
