# frozen_string_literal: true

class User::RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find(params[:user_id])
    current_user.follow(@user.id)
  end

  def destroy
    @user = User.find(params[:user_id])
    current_user.unfollow(@user.id)
  end

  def followings
    user = User.find(params[:user_id])
    @followers = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @followings = user.followers
  end
end
