# frozen_string_literal: true

class User::UsersController < ApplicationController
  def show
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']
    @user = User.find(params[:id])
    @tweets = @user.tweets.page(params[:page]).per(20).reverse_order
    gon.tweet_id_list = @tweets.ids
    # 新規投稿用
    @new_tweet = Tweet.new
  end

  def setting
    @user = current_user
  end

  def exit; end

  def destroy
    user = current_user
    user.update!(is_active: false)
    reset_session
    redirect_to root_path, notice: 'ありがとうございました。またのご利用を心よりお待ちしております。'
  end
end
