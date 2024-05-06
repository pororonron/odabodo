class Public::IllustrationCommentsController < ApplicationController
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
end
