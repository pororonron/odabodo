class Public::ThemesController < ApplicationController
  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
  end

  def index

  end

  def show
  end

  def confirm
  end

  private

  def theme_params
    configure(:theme).permit(:title, :detail)
  end
end
