class Admin::IllustrationCommentsController < ApplicationController
  def destroy
    IllustrationComment.find(params[:id]).destroy
    redirect_to admin_illustration_path(params[:illustration_id])
  end
end
