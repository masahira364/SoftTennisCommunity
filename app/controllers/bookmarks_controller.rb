class BookmarksController < ApplicationController
  def create
    bookmark = current_user.bookmarks.build(team_id: params[:team_id])
    bookmark.save!
    redirect_to request.referer, notice: "チームをブックマークしました"
  end

  def destroy
    current_user.bookmarks.find_by(team_id: params[:team_id]).destroy!
    redirect_to request.referer, alert: "チームのブックマークを外しました"
  end
end
