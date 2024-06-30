class Public::IllustrationsController < ApplicationController
  def new
    @illustration = Illustration.new
  end

  def create
    @illustration = current_end_user.illustrations.new(illustration_params)
    # @select_themes = current_end_user.challenge_themes.theme.map { |theme_id| Theme.find(theme_id) }
    # @illustration = current_end_user.illustrations.new(challenged_images_resize(illustration_params))

    if @illustration.save
      redirect_to illustration_path(@illustration)
    else
      render :new
    end
  end

  def index
    @illustrations = Illustration.all
    @themes = Theme.where(is_active: true)
  end

  def show
    @illustration = Illustration.find(params[:id])
    @illustration_tags = @illustration.illustration_tags.pluck(:name)
    @illustration_comment = IllustrationComment.new
  end


  def edit
    @illustration = Illustration.find(params[:id])
    @select_themes = current_end_user.challenge_themes.theme.map { |theme_id| Theme.find(theme_id) }
  end

  def update
    @illustration = current_end_user.illustrations.find(params[:id])
    # if params[:illustration][:challenged_image_ids]
    #   params[:illustration][:challenged_image_ids].each do |challenged_image_id|
    #     challenged_image = @illustration.challenged_images.find(challenged_image_id)
    #     challenged_image.purge
    #   end
    # end

    if @illustration.update(illustration_params)
      if params[:illustration][:challenged_image_ids]
        params[:illustration][:challenged_image_ids].each do |challenged_image_id|
          challenged_image = @illustration.challenged_images.find(challenged_image_id)
          challenged_image.purge
      end
    end
      redirect_to illustration_path(@illustration.id)
    else
      render :edit
    end
  end

  def destroy
    illustration = Illustration.find(params[:id])
    illustration.destroy
    redirect_to root_path
  end

  # def challenged_images_resize(params)
  #   if params[:challenged_images]
  #     params[:challenged_images].each do |challenged_image|
  #       challenged_image.tempfile = ImageProcessing::MiniMagick.source(challenged_image.path).resize_to_limit(1000, 1000).call
  #     end
  #   end
  #   params
  # end

  private

  def illustration_params
    params.require(:illustration).permit(:theme_id, :title, :detail, :illustration_tag_name, challenged_images: [])
  end

  def is_matching_login_end_user
    illustration = Illustration.find(params[:id])
    unless illustration.end_user_id == current_end_user.id
      redirect_to illustration_path(illustration)
    end
  end
end
