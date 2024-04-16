class Public::ThemesController < ApplicationController
  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)
    theme_tags = params[:theme][:name].split(',')
    @theme.end_user_id = current_end_user.id
    if @theme.save!
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
    @theme_tags = @theme.theme_tags.pluck(:name)
  end

  def edit
    @theme = Theme.find(params[:id])
    @theme_tags = @theme.theme_tags.pluck(:name).join(',')
  end

  def update
    @theme = Theme.find(params[:id])
    @theme_tags = @theme.theme_tags.pluck(:name).join(',')
    theme_tags = params[:theme][:name].split(',')
    @theme.end_user_id = current_end_user.id
    if @theme.update(theme_params)
      @theme.update_theme_tags(theme_tags)
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
    params.require(:theme).permit(:title, :detail, :reference_image)
  end
end
