class Public::ThemesController < ApplicationController
  def new
    @theme = Theme.new
    @theme_tag = ThemeTag.new
  end

  def create
    @theme = current_end_user.themes.new(theme_params)
    theme_tags = params[:theme][:theme_tag_id].split(',')
    if @theme.save
      @theme.save_theme_tags(theme_tags)
      redirect_to theme_path(@theme.id)
    else
      render :new
    end
  end

  def index
    @themes = Theme.all
  end

  def show
    @theme = Theme.find(params[:id])
  end

  def edit
    @theme = Theme.find(params[:id])
    @theme_tags = @theme.theme_tags.pluck(:name).join(',')
  end

  def update
    @theme = Theme.find(params[:id])
    theme_tags = params[:theme][:theme_tag_id].split(',')
    if @theme.update(theme_params)
      @theme.update_theme_tags(theme_tags)
      redirect_to theme_path(@theme.id)
    else
      render :edit
    end
  end

  def confirm
  end

  private

  def theme_params
    params.require(:theme).permit(:title, :detail, :reference_image)
  end
end
