# frozen_string_literal: true

class Admin::TweetsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tweets = Tweet.all.page(params[:page]).per(10)
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def edit
    @tweet = Tweet.find(params[:id])
    @site_url = @tweet.site.url
  end

  def update
    tweet = Tweet.find(params[:id])
    if tweet.update(tweet_params)
      redirect_to admin_tweet_path(tweet.id)
    else
      render :edit
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:user_id, :site_id, :text, :is_opened, :tag_list)
  end
end
