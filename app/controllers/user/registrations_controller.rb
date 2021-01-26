# frozen_string_literal: true

class User::RegistrationsController < Devise::RegistrationsController
  before_action :authenticate_user!
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    super
  end

  # GET /resource/edit
  def edit
    super
  end

  # PUT /resource
  def update
    super
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # 新規登録時にemailとpasswordのほかに追加で入力してもらう情報
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name image_id text is_active])
  end

  # If you have extra params to permit, append them to the sanitizer.
  # ユーザー情報更新時にemailとpasswordのほかに追加で更新したい情報
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name image text is_active])
  end

  # The path used after sign up.
  # 新規登録後の遷移先をオーバーライド
  def after_sign_up_path_for(_resource)
    home_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  # パスワード入力なしでユーザー情報を更新できるようにする
  def update_resource(resource, params)
    resource.update_without_current_password(params)
  end

  # ユーザー情報更新後の遷移先をオーバーライド
  def after_update_path_for(_resource)
    user_path(current_user.id)
  end
end
