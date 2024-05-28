class Admin::ThemesController < ApplicationController
  layout 'admin'
  before_action :is_active, only: [:show, :edit]

  def index
    @themes = Theme.where(is_active: true)
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
    @end_user = EndUser.find(params[:id])
    @theme = @end_user.themes.find(params[:id])
    if params[:theme][:reference_image_ids]
      params[:theme][:reference_image_ids].each do |reference_image_id|
        reference_image = @theme.reference_images.find(reference_image_id)
        reference_image.purge
      end
    end

    if @theme.update(reference_images_resize(theme_params))
      redirect_to admin_theme_path(@theme.id)
    else
      render :edit
    end
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
    theme = Theme.find(params[:id])
    theme.update(is_active: false ,theme_tag_name: "deleted")
    flash[:notice] = "お題を削除しました。"
    redirect_to theme_and_illustration_admin_homes_path
  end

  private

  def theme_params
    params.require(:theme).permit(:title, :detail, :theme_tag_name, reference_images: [])
  end

  def is_active
    theme = Theme.find(params[:id])
    unless theme.is_active == true
      redirect_to request.referer
    end
  end
end
