# frozen_string_literal: true

class User::UsersController < ApplicationController
  def show
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']
    @user = User.find(params[:id])
    @tweets = @user.tweets.page(params[:page]).reverse_order
    gon.tweet_id_list = @tweets.ids
  end
end
