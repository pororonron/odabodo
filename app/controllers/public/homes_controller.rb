class Public::HomesController < ApplicationController
  before_action :authenticate_end_user!, except: [:choice]

  def top
    @themes = Theme.all
    @illustrations = Illustration.all
  end

  def choice
  end

  def search
    if params[:title].present?
      @themes = Theme.where('title LIKE?', "%#{params[:title]}%")
      @illustrations = Illustration.where('title LIKE?', "%#{params[:title]}%")
      @end_users = EndUser.where('name LIKE?', "%#{params[:title]}%")
    else
      @themes = Theme.none
      @illustrations = Illustration.none
      @end_users = EndUser.none
    end

    # if params[:name].present?
    #   @themes = Theme.where('tag LIKE?', "%#{params[:tag]}%")
    #   @illustrations = Illustration.where('tag LIKE?', "%#{params[:tag]}%")
    # else
    #   @themes = Theme.none
    #   @illustrations = Illustration.none
    # end
  end
  end

  def search_tag

end
