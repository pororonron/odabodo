# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :end_user_state, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def guest_sign_in
    end_user = EndUser.guest
    sign_in end_user
    redirect_to root_path, notice: "テスト：ゲスト状態です"
  end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    choice_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  private
  
  def end_user_state
    end_user = EndUser.find_by(params[:end_user][:email])
    return if end_user.nill?
    return unless end_user.valid_password?(params[:end_user][:password])
    return if end_user(is_active: true)?
    reset_session
    redirect_to choice_path
  end
  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
