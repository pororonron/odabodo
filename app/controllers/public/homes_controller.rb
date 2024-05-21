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
      theme_tag = ThemeTag.find_by(name: params[:title])
      if theme_tag
        @themes = theme_tag.themes
      else
        @themes = Theme.none
      end

      illustration_tag = IllustrationTag.find_by(name: params[:title])
      if illustration_tag
        @illustrations = illustration_tag.illustrations
      else
        @illustrations = IllustrationTag.none
      end
    else
      @themes = Theme.none
      @illustrations = Illustration.none
    end
  end

end
