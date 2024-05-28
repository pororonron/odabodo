class Admin::ThemeCommentsController < ApplicationController
  def destroy
    ThemeComment.find(params[:id]).destroy
    redirect_to admin_theme_path(params[:theme_id])
  end
end
