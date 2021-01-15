# frozen_string_literal: true

class User::SearchesController < ApplicationController
  def result
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']

    # 検索フォームから取得した情報
    @search_target = params[:target] # 検索対象
    @search_type = params[:type] # 検索種別

    # 何も入力されていない場合は検索結果0件
    if @search_target == ''
      @tweets = Tweet.none.page(params[:page]).reverse_order
      gon.tweet_id_list = Tweet.none.ids
    else
      # 退会済みユーザーの投稿および非公開設定になっている投稿は除外する
      active_tweet = Tweet.where(user_id: User.where(is_active: true).ids, is_opened: true)

      # 検索種別で場合分け
      case @search_type
      when 'ユーザー'
        users = User.where('name like ?', "%#{@search_target}%")
        results = Tweet.where(user_id: users.ids)

      when '投稿記事'
        results = Tweet.where('text like ?', "%#{@search_target}%")

      when '投稿URL'
        sites = Site.where(' url like ?', "%#{@search_target}%")
        results = Tweet.where(site_id: sites.ids)

      else
        results = Tweet.tagged_with(@search_target.to_s)
      end

      # 検索結果を満たす投稿を抽出
      searched_tweet = active_tweet.where(id: results.ids)
      @tweets = searched_tweet.page(params[:page]).reverse_order
      gon.tweet_id_list = @tweets.ids
    end
  end
end
