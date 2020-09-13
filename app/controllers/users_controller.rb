class UsersController < ApplicationController
  before_action :set_user, only: [
    :show, :edit, :update, :destroy,
    :bookmarks, :favorites, :entries, :confirm,
  ]

  before_action :correct_user, only: [:edit, :destroy]

  def show
  end

  def edit
  end

  def destroy
    @user.destroy
    redirect_to root_path, notice: '退会しました。ご利用ありがとうございました。'
  end

  def update
    if current_user.team_id.present?
      @team = Team.find(current_user.team_id)
    end
    if @user.update(user_params)
      # プロフィール更新時
      if params[:user][:team_id] == nil
        redirect_to user_path(@user), notice: "プロフィールを更新しました"
      # チーム参加承認時
      elsif params[:user][:team_id] != nil
        # チーム脱退時の処理
        if @user.team_id.nil?
          @approval = Notification.new(visitor_id: @user.id,
                                       team_visited_id: params[:team_id],
                                       action: 'withdrawal')
          @approval.save
          # チームのメンバーがだれもいなければチーム削除
          if @team.users.empty?
            @team.destroy
          end
          redirect_to user_path(current_user), alert: "チームを脱退しました"
        else
          # 承認申請を削除
          @approval = Approval.find_by(team_id: params[:user][:team_id],
                                       user_id: @user.id, event_id: nil)
          @approval.destroy
          # 参加の通知を作成
          @user.create_notification_user(@user)
          redirect_to request.referer, notice: "#{@user.nickname}さんがチームに参加しました"
        end
      end
    else
      render :edit
    end
  end

  def bookmarks
  end

  def favorites
    @articles = @user.favorite_articles
  end

  def entries
    @events = @user.entry_events
  end

  def confirm
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # 他ユーザーの遷移防止
  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), alert: "他の会員の情報編集・削除は禁止です"
    end
  end

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
      :team_id
    )
  end
end
