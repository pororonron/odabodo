class Public::ChallengeThemesController < ApplicationController
  def create
    theme = Theme.find(params[:theme_id])
    challenge_theme = current_end_user.challenge_themes.new(theme_id: theme.id)
    challenge_theme.save
    redirect_to theme_path(theme)
  end
  
  def destroy
    theme = Theme.find(params[:theme_id])
    challenge_theme = current_end_user.challenge_themes.find_by(theme_id: theme.id)
    challenge_theme.destroy
    redirect_to theme_path(theme)
  end
end
