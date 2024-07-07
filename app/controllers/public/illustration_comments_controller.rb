class Public::IllustrationCommentsController < ApplicationController
  before_action :is_matching_login_end_user, only: [:destroy], unless: :admin_controller?
  def create
    illustration = Theme.find(params[:illustration_id])
    illustration_comment = current_end_user.illustration_comments.new(illustration_comment_params)
    illustration_comment.illustration_id = illustration.id
    illustration_comment.save
    redirect_to illustration_path(illustration)
  end

  def destroy
    IllustrationComment.find(params[:id]).destroy
    redirect_to illustration_path(params[:illustration_id])
  end

  private

  def illustration_comment_params
    params.require(:illustration_comment).permit(:comment)
  end

  def is_matching_login_end_user
    illustration_comment = IllustrationComment.find(params[:id])
    unless illustration_comment.end_user_id == current_end_user.id
      redirect_to illustration_path(illustration_comment.illustration)
    end
  end

  def admin_controller?
    self.class.module_parent_name == "Admin"
  end
end
