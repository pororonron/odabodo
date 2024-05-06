class Public::ThemeCommentsController < ApplicationController
  def create
    theme = Theme.find(params[:theme_id])
    theme_comment = current_end_user.theme_comments.new(theme_comment_params)
    theme_comment.theme_id = theme.id
    theme_comment.save
    redirect_to theme_path(theme)
  end

  def destroy
    ThemeComment.find(params[:id]).destroy
    redirect_to theme_path(params[:theme_id])
  end

  private

  def theme_comment_params
    params.require(:theme_comment).permit(:comment)
  end
end
