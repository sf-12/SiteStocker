# frozen_string_literal: true

class User::HomesController < ApplicationController
  def home
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']
    # 退会済みユーザーの投稿および非公開設定になっている投稿は除外する
    active_tweet = Tweet.where(user_id: User.where(is_active: true).ids, is_opened: true)
    @tweets = active_tweet.page(params[:page]).per(20).reverse_order
    gon.tweet_id_list = @tweets.ids
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

  def about; end
end
