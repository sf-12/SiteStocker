# frozen_string_literal: true

class Admin::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :authenticate_admin!
  before_action :sign_out_user

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

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # ログイン後に遷移するパス
  def after_sign_in_path_for(_resource)
    admin_path
  end

  # ログアウト後に遷移するパス
  def after_sign_out_path_for(_resource)
    new_admin_session_path
  end

  # ユーザー側でサインインしている場合はサインアウトする
  def sign_out_user
    return unless user_signed_in?

    sign_out(current_user)
    flash[:warning] = 'ユーザー側サイトはサインアウトしました'
  end
end
