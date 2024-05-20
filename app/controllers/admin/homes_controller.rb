class Admin::HomesController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin!

  def top
  end

  def theme_and_illustration
    @themes = Theme.all
    @illustrations = Illustration.all
  end

  def search
    @content = params["title"]
    if params[:title].present?
      @themes = Theme.where('title LIKE?', "%#{params[:title]}%")
      @illustrations = Illustration.where('title LIKE?', "%#{params[:title]}%")
      @end_users = EndUser.where('name LIKE?', "%#{params[:title]}%")
    else
      @themes = Theme.none
      @illustrations = Illustration.none
      @end_users = EndUser.none
    end
  end

  def search_tag
    @content = params["title"]
    if params[:title].present?
      # @themes = ThemeTag.find('name LIKE?', "%#{params[:title]}%").themes.all
      @themes = ThemeTag.where('name LIKE?', "#{params[:title]}")
      @illustrations = params[:name].present? ? IllustrationTag.find(params[:title]).illustrations : Illustration.all
    else
      @themes = Theme.none
      @illustrations = Illustration.none
    end
  end

  def comment
    @themes = ThemeComment.all
    @illustrations = IllustrationComment.all
  end
end
