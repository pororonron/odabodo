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
      theme_tags = ThemeTag.where('name LIKE?', "%#{params[:title]}%")
      @theme = theme_tags.theme_tag_middle
      @illustrations = IllustrationTag.where('name LIKE?', "%#{params[:title]}%")
    else
      @themes = ThemeTag.none
      @illustrations = IllustrationTag.none
    end
  end

end
