class Public::HomesController < ApplicationController
  before_action :authenticate_end_user!, except: [:choice]

  def top
    @themes = Theme.all
    @illustrations = Illustration.all
  end

  def choice
  end
end
