class Public::ThemesController < ApplicationController
  def new
    @theme = Theme.new
  end

  def create
    @theme = current_end_user.themes.new(reference_images_resize(theme_params))
    if @theme.save
      redirect_to theme_path(@theme)
    else
      render :new
    end
  end

  def index
    @themes = Theme.all
    @illustrations = Illustration.all
  end

  def show
    @theme = Theme.find(params[:id])
    @theme_tags = @theme.theme_tags.pluck(:name)
    @theme_comment = ThemeComment.new
  end

  def edit
    @theme = Theme.find(params[:id])
  end

  def update
    @theme = current_end_user.themes.find(params[:id])
    if params[:theme][:reference_image_ids]
      params[:theme][:reference_image_ids].each do |reference_image_id|
        reference_image = @theme.reference_images.find(reference_image_id)
        reference_image.purge
      end
    end

    if @theme.update(reference_images_resize(theme_params))
      redirect_to theme_path(@theme.id)
    else
      render :edit
    end
  end

  def destroy
    theme = Theme.find(params[:id])
    theme.destroy
    redirect_to root_path
  end

  def reference_images_resize(params)
    if params[:reference_images]
      params[:reference_images].each do |reference_image|
        reference_image.tempfile = ImageProcessing::MiniMagick.source(reference_image.path).resize_to_limit(500, 500).call
      end
    end
    params
  end

  def challenged_image
    @theme = Theme.find(params[:id])
    @content = @theme.title
    if @theme.illustrations
      @illustrations = @theme.illustrations
    else
      @illustrations = Illustration.none
    end
  end

  def withdraw
    @theme = Theme.find(params[:id])
    @theme.update(is_active: false)
    flash[:notice] = "お題を削除しました。"
    redirect_to root_path
  end

  private

  def theme_params
    params.require(:theme).permit(:title, :detail, :theme_tag_name, reference_images: [])
  end

  def is_matching_login_end_user
    theme = Theme.find(params[:id])
    unless theme.end_user_id == current_end_user.id
      redirect_to theme_path(theme)
    end
  end
end
