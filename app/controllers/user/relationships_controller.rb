# frozen_string_literal: true

class User::RelationshipsController < ApplicationController
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
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
