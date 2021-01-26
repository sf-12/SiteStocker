# frozen_string_literal: true

class User::HomesController < ApplicationController
  # ログインページ、新規登録ページ以外はサインインしていないとアクセスできないが、topページはアクセス可能
  before_action :authenticate_user!, except: [:top]

  def top
    # 管理者側でログインしている場合はログアウトする
    if admin_signed_in?
      sign_out_and_redirect(current_admin)
      flash[:alert] = '管理者側サイトはサインアウトしました'
    end

    # ユーザー側でログインしている場合はホーム画面へ移動
    return unless user_signed_in?

    flash[:notice] = 'ログイン済みです'
    redirect_to home_path
  end

  def home
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']
    # 退会済みユーザーの投稿および非公開設定になっている投稿は除外するx
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
