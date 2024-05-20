class Public::HomesController < ApplicationController
  before_action :authenticate_end_user!, except: [:choice]

  def top
    @themes = Theme.all
    @illustrations = Illustration.all
  end

  def choice
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
      theme_tag = ThemeTag.find_by(name: params[:title])
      @themes =  theme_tag.themes

      @illustrations = params[:name].present? ? IllustrationTag.find(params[:title]).illustrations : Illustration.all
    else
      @themes = Theme.none
      @illustrations = Illustration.none
    end
  end

end
