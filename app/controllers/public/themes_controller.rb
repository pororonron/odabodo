class Public::ThemesController < ApplicationController
  def new
    @theme = Theme.new
  end

  def create
    @theme = current_end_user.themes.new(theme_params)
    if @theme.save
      redirect_to theme_path(@theme)
    else
      render :new
    end
  end

  def index
    @themes = Theme.all
  end

  def show
    @theme = Theme.find(params[:id])
    @theme_tags = @theme.theme_tags.pluck(:name)
  end

  def edit
    @theme = Theme.find(params[:id])
  end

  def update
    @theme = Theme.find(params[:id])
    @theme.end_user_id = current_end_user.id
    if @theme.update(theme_params)
      redirect_to theme_path(@theme.id)
    else
      render :edit
    end
  end

  def confirm
  end

  def delete
    theme = Theme.find(params[:id])
    theme.destroy
    redirect_to root_path
  end

  private

  def theme_params
    params.require(:theme).permit(:title, :detail, :theme_tag_name, reference_images: [])
  end
end
