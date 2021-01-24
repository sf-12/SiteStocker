# frozen_string_literal: true

class User::UsersController < ApplicationController
  def show
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']
    @user = User.find(params[:id])

    # 閲覧者が本人でない場合、非公開の投稿は表示しない
    # if @user != current_user
    #   active_tweet = @user.tweets.where(is_opened: true)
    # else
    #   active_tweet = @user.tweets
    # end
    active_tweet = if @user == current_user
                     @user.tweets
                   else
                     @user.tweets.where(is_opened: true)
                   end
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
