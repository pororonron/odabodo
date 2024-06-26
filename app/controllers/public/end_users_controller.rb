class Public::EndUsersController < ApplicationController
  before_action :ensure_guest_end_user, only: [:edit]
  before_action :is_active, only: [:show, :edit, :follows]

  def show
    @end_user = EndUser.find(params[:id])
    @themes = @end_user.themes.where(is_active: true)
    @illustrations = @end_user.illustrations.all

    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:illustration_id)
    @favorite_illustrations = Illustration.find(favorites)

    bookmarks = Bookmark.where(end_user_id: @end_user.id).pluck(:illustration_id)
    @bookmark_illustrations = Illustration.find(bookmarks)

    challenge_themes = ChallengeTheme.where(end_user_id: @end_user.id).pluck(:theme_id)
    @challenge_themes = Theme.where(is_active: true, id: challenge_themes)
  end

  def edit
    @end_user = current_end_user
  end

  def update
    @end_user = current_end_user

    if current_end_user.update(end_user_params)
      redirect_to end_user_path(current_end_user)
    else
      render :edit
    end
  end

  def confirm
  end

  def follows
    @end_user = EndUser.find(params[:id])
    # @end_users = @end_user.following_end_users
    @following_end_users = @end_user.following_end_users
    @follower_end_users = @end_user.follower_end_users
  end

  def withdraw
    current_end_user.update(is_active: false)
    current_end_user.following_end_users.destroy_all
    current_end_user.follower_end_users.destroy_all
    current_end_user.illustrations.destroy_all
    current_end_user.illustration_comments.destroy_all
    current_end_user.theme_comments.destroy_all
    current_end_user.themes.update_all(is_active: false)

    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to choice_homes_path
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :self_introduction, :profile_image, :is_active)
  end

  def is_matching_login_end_user
    end_user = EndUser.find(params[:id])
    unless end_user.id == current_end_user.id
      redirect_to end_user_path
    end
  end

  def ensure_guest_end_user
    @end_user = EndUser.find(params[:id])
    if @end_user.guest_end_user?
      redirect_to end_user_path(current_end_user),
        notice: "ゲストユーザーはプロフィール編集画面へ遷移できません。"
    end
  end

  def is_active
    end_user = EndUser.find(params[:id])
    unless end_user.is_active == true
      redirect_to root_path
    end
  end
end
