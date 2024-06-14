class Public::HomesController < ApplicationController
  before_action :authenticate_end_user!, except: [:choice]

  def top
    @themes = Theme.where(is_active: true)
    @illustrations = Illustration.all
  end

  def choice
  end

  def search
    @content = params["title"]
    if params[:title].present?
      @themes = Theme.where('title LIKE ? AND is_active = ?', "%#{params[:title]}%", true)
      @illustrations = Illustration.where('title LIKE?', "%#{params[:title]}%")
      @end_users = EndUser.where('name LIKE ? AND is_active = ?', "%#{params[:title]}%", true)
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
        @themes = theme_tag.themes.where(is_active: true)
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
