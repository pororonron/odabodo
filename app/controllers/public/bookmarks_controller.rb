class Public::BookmarksController < ApplicationController
  def create
    illustration = Illustration.find(params[:illustration_id])
    bookmark = current_end_user.bookmarks.new(illustration_id: illustration.id)
    bookmark.save
    redirect_to illustration_path(illustration)
  end

  def destroy
    illustration = Illustration.find(params[:illustration_id])
    bookmark = current_end_user.bookmarks.find_by(illustration_id: illustration.id)
    bookmark.destroy
    redirect_to illustration_path(illustration)
  end
end
