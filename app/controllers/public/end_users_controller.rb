class Public::EndUsersController < ApplicationController
  def show
    @end_user = EndUser.find(params[:id])
    @themes = Theme.all
    @illustrations = Illustration.all

    favorites = Favorite.where(end_user_id: @end_user.id).pluck(:illustration_id)
    @favorite_illustrations = Illustration.find(favorites)

    bookmarks = Bookmark.where(end_user_id: @end_user.id).pluck(:illustration_id)
    @bookmark_illustrations = Illustration.find(bookmarks)

    challenge_themes = ChallengeTheme.where(end_user_id: @end_user.id).pluck(:theme_id)
    @challenge_themes = Theme.find(challenge_themes)
  end

  def edit
    @end_user = EndUser.find(params[:id])
  end

  def update
    @end_user = EndUser.find(params[:id])
    if @end_user.update(end_user_params)
      redirect_to end_user_path(@end_user.id)
    else
      render :edit
    end
  end

  def confirm
  end

  private

  def end_user_params
    params.require(:end_user).permit(:name, :self_introduction, :profile_image)
  end
end
