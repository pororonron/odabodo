class Public::ThemeCommentsController < ApplicationController
  before_action :is_matching_login_end_user, only: [:destroy], unless: :admin_controller?
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

  def is_matching_login_end_user
    theme_comment = ThemeComment.find(params[:id])
    unless theme_comment.end_user_id == current_end_user.id
      redirect_to theme_path(theme_comment.theme)
    end
  end

  def admin_controller?
    self.class.module_parent_name == "Admin"
  end
end
