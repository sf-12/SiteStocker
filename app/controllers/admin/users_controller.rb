# frozen_string_literal: true

class Admin::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_params)
      sleep(3) # S3への画像反映のタイムラグを考慮して3秒待機
      redirect_to admin_user_path(user.id)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:image, :name, :text, :is_active)
  end
end
