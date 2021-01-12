# frozen_string_literal: true

class User::TweetsController < ApplicationController
  def new; end

  def create
    # サイトを保存する
    site = Site.create(url: params[:url])
    # タグを保存する
    # TODO: タグ保存機能の作成
    # 投稿を保存する
    tweet = Tweet.new(user_id: current_user.id, site_id: site.id, text: params[:text])
    if tweet.save
      # ホーム画面に戻る
      redirect_to home_path
    else
      render :new
    end
  end

  def show
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']
    @tweet = Tweet.find(params[:id])
    # データは1つだが配列として渡す
    gon.tweet_id_list = [@tweet.id]
  end

  def edit
    @tweet = Tweet.find(params[:id])
    @site_url = @tweet.site.url
  end

  def update
    # サイトを保存する
    tweet = Tweet.find(params[:id])
    site = tweet.site.id
    site.update(url: params[:tweet][:url])
    # タグを保存する
    # TODO: タグ保存機能の作成
    # 投稿を保存する
    if tweet.update(site_id: site.id, text: params[:tweet][:text])
      # ホーム画面に戻る
      redirect_to tweet_path(tweet.id)
    else
      render :edit
    end
  end

  def destroy
    tweet = Tweet.find(params[:id])
    return unless tweet.user_id == current_user.id

    tweet.destroy
    flash[:error] = '投稿を削除しました'
    redirect_to user_path(current_user.id)
  end
end
