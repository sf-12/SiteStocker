# frozen_string_literal: true

class ApplicationController < ActionController::Base
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
    logger.debug "ranking_month: #{ranking_month}"
    logger.debug "ranking_year: #{ranking_year}"
    logger.debug "ranking_all: #{ranking_all}"
    [ranking_month, ranking_year, ranking_all]
  end

  # タグのランキングを集計して返す
  def tag_ranking
    buf = ActsAsTaggableOn::Tagging.where(taggable_id: Tweet.where(is_opened: true)).group(:tag_id)
    # 月間
    month_buf = buf.where(taggable_id: Tweet.span_month).order(Arel.sql('count(tag_id) desc')).limit(10)
    ranking_month = month_buf.pluck(:tag_id)
    ranking_month_count = month_buf.count.values
    # 年間
    year_buf = buf.where(taggable_id: Tweet.span_year).order(Arel.sql('count(tag_id) desc')).limit(10)
    ranking_year = year_buf.pluck(:tag_id)
    ranking_year_count = year_buf.count.values
    # 全期間
    all_buf = buf.order(Arel.sql('count(tag_id) desc')).limit(10)
    ranking_all = all_buf.pluck(:tag_id)
    ranking_all_count = all_buf.count.values
    [ranking_month, ranking_month_count, ranking_year, ranking_year_count, ranking_all, ranking_all_count]
  end
end
