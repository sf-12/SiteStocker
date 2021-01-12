# frozen_string_literal: true

class User::HomesController < ApplicationController
  def home
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']
    # 退会済みユーザーの投稿は除外する
    active_tweet = Tweet.where(user_id: User.where(is_active: true).ids)
    @tweets = active_tweet.page(params[:page]).reverse_order
    gon.tweet_id_list = @tweets.ids
  end

  def about; end
end
