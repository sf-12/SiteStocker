# frozen_string_literal: true

class User::SearchesController < ApplicationController
  before_action :authenticate_user!

  def result
    # 検索フォームから取得した情報
    @search_target = params[:target]  # 検索対象
    @search_type = params[:type]      # 検索種別
    @search_period = params[:period]  # 検索期間
    # 検索
    @tweets = search_tweet(@search_target, @search_type, @search_period)
    # APIキーと投稿リストを外部APIに渡す
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']
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

  private

  # 検索内容に該当する投稿のid一覧を取得する
  # target: 検索内容
  # type:   検索種別（ユーザー or 投稿記事 or 投稿URL or タグ）
  # period: 検索期間（month or year or all）
  def search_tweet(target, type, period)
    # 何も入力されていない場合は検索結果0件
    if target == ''
      Tweet.none.page(params[:page]).reverse_order
    else
      # 検索種別で場合分け
      case type
      when 'ユーザー'
        users = User.where('name like ?', "%#{target}%")
        results = Tweet.where(user_id: users.ids)
      when '投稿記事'
        results = Tweet.where('text like ?', "%#{target}%")
      when '投稿URL'
        sites = Site.where(' url like ?', "%#{target}%")
        results = Tweet.where(site_id: sites.ids)
      else
        # タグ検索の場合
        results = Tweet.tagged_with(target.to_s)
      end

      # 退会済みユーザーの投稿および非公開設定になっている投稿は除外する
      active_tweet = Tweet.where(user_id: User.where(is_active: true).ids, is_opened: true)
      # 集計期間外の投稿は除外する
      in_period_tweet = case period
                        when 'month'
                          active_tweet.span_month
                        when 'year'
                          active_tweet.span_year
                        else
                          active_tweet
                        end

      # 検索結果を満たす投稿を抽出
      in_period_tweet.where(id: results.ids).page(params[:page]).reverse_order
    end
  end
end
