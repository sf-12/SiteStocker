# frozen_string_literal: true

class User::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_user, only: [:create]
  before_action :authenticate_user!

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # 簡単ログイン機能
  def new_guest
    user = User.guest_login
    sign_in user
    flash[:notice__upper] = 'ゲストユーザーとしてログインしました'
    redirect_to home_path
  end

  # クラス内、同一パッケージ、サブクラスからのみアクセス可
  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  # ログイン後に遷移するパス
  def after_sign_in_path_for(_resource)
    home_path
  end

  # ログアウト後に遷移するパス
  def after_sign_out_path_for(_resource)
    root_path
  end

  # 退会済みユーザーがログインできないようにする
  def reject_user
    @user = User.find_by(email: params[:user][:email].downcase)
    return unless @user
    return unless @user.valid_password?(params[:user][:password]) && (@user.is_active == false)

    flash[:alert] = '退会済みのアカウントです'
    redirect_to new_user_session_path
  end
end
