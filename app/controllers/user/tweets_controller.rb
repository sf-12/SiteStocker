# frozen_string_literal: true

class User::TweetsController < ApplicationController
  def create
    # サイトがデータベースに無ければ保存する
    site = Site.find_by(url: params[:tweet][:url])
    site = Site.create(url: params[:tweet][:url]) if site.nil?

    # 投稿を保存する
    new_tweet = Tweet.new(tweet_params)
    new_tweet.user_id = current_user.id
    new_tweet.site_id = site.id
    if new_tweet.save
      # マイページに戻る
      redirect_to user_path(current_user.id)
    else
      render request.referer
    end
  end

  def show
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']
    @tweet = Tweet.find(params[:id])
    # データは1つだが配列として渡す
    gon.tweet_id_list = [@tweet.id]
    @new_comment = Comment.new
    # いいね数ランキング
    @ranking_likes_month, @ranking_likes_year, @ranking_likes_all = tweet_ranking('likes')
    # コメント数ランキング
    @ranking_comments_month, @ranking_comments_year, @ranking_comments_all = tweet_ranking('comments')
    # タグランキング
    @ranking_tags_month, @ranking_tags_month_count,
    @ranking_tags_year, @ranking_tags_year_count,
    @ranking_tags_all, @ranking_tags_all_count = tag_ranking
    # 新規投稿用
    @new_tweet = Tweet.new
  end

  def edit
    @tweet = Tweet.find(params[:id])
    @site_url = @tweet.site.url
  end

  def update
    # サイトを保存する
    tweet = Tweet.find(params[:id])
    site = tweet.site
    site.update(url: params[:tweet][:url])
    # 投稿を保存する
    tweet.site_id = site.id
    if tweet.update(tweet_params)
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
    flash[:alert] = '投稿を削除しました'
    redirect_to user_path(current_user.id)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:user_id, :site_id, :text, :is_opened, :tag_list)
  end
end
