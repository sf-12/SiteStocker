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
  end

  def about; end

  private

  # いいね数orコメント数のランキングを集計して返す
  def tweet_ranking(type)
    buf = if type == 'likes'
            # いいね数
            Tweet.where(is_opened: true).joins(:likes).select('tweets.*, likes.*').group(:tweet_id)
          else
            # コメント数
            Tweet.where(is_opened: true).joins(:comments).select('tweets.*, comments.*').group(:tweet_id)
          end
    # 月間・年間・全期間
    ranking_month = buf.span_month.order(Arel.sql('count(tweet_id) desc')).limit(10).pluck(:tweet_id)
    ranking_year = buf.span_year.order(Arel.sql('count(tweet_id) desc')).limit(10).pluck(:tweet_id)
    ranking_all = buf.order(Arel.sql('count(tweet_id) desc')).limit(10).pluck(:tweet_id)
    [ranking_month, ranking_year, ranking_all]
  end

  # タグのランキングを集計して返す
  def tag_ranking
    buf = ActsAsTaggableOn::Tagging.where(taggable_id: Tweet.where(is_opened: true)).group(:tag_id)
    # 月間
    month_buf = buf.where(created_at: tagging_span_month).order(Arel.sql('count(tag_id) desc')).limit(10)
    ranking_month = month_buf.pluck(:tag_id)
    ranking_month_count = month_buf.count.values
    # 年間
    year_buf = buf.where(created_at: tagging_span_year).order(Arel.sql('count(tag_id) desc')).limit(10)
    ranking_year = year_buf.pluck(:tag_id)
    ranking_year_count = year_buf.count.values
    # 全期間
    all_buf = buf.order(Arel.sql('count(tag_id) desc')).limit(10)
    ranking_all = all_buf.pluck(:tag_id)
    ranking_all_count = all_buf.count.values
    [ranking_month, ranking_month_count, ranking_year, ranking_year_count, ranking_all, ranking_all_count]
  end

  # 今月１ヶ月間
  def tagging_span_month
    Time.now.in_time_zone.all_month
  end

  # 今年１年間
  def tagging_span_year
    Time.now.in_time_zone.all_year
  end
end
