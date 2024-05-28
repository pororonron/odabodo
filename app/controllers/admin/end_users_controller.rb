class Admin::EndUsersController < ApplicationController
  layout 'admin'

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
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to admin_end_user_path(@end_user)
    else
      render :edit
    end
  end

  def confirm
    @end_user = EndUser.find(params[:id])
  end

  def follows
    @end_user = EndUser.find(params[:id])
    @following_end_users = @end_user.following_end_users
    @follower_end_users = @end_user.follower_end_users
  end

  def withdraw
    end_user = EndUser.find(params[:id])
    end_user.update(is_active: false)
    end_user.following_end_users.destroy_all
    end_user.follower_end_users.destroy_all
    end_user.illustrations.destroy_all
    end_user.illustration_comments.destroy_all
    end_user.theme_comments.destroy_all
    end_user.themes.update_all(is_active: false)

    reset_session
    flash[:notice] = "退会処理を実行しました。"
    redirect_to admin_root_path
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
end
