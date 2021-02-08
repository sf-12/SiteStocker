# frozen_string_literal: true

class User::UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']
    @user = User.find(params[:id])

    # 閲覧者が本人でない場合、非公開の投稿は表示しない
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

  def update
    @user = current_user
    if @user.update(user_params)
      sign_in(@user, bypass: true)
      flash[:notice__upper] = 'パスワードを変更しました'
      redirect_to user_path(current_user.id)
    else
      render :setting
    end
  end

  def exit; end

  def destroy
    user = current_user
    if user.email == 'guest@example.com'
      # ゲストユーザーは退会させず、プロフィールを初期化
      user.name = 'ゲストユーザー'
      user.is_active = true
      user.text = 'よろしくお願いします！'
      user.image_id = nil
    else
      # 一般ユーザーは退会させる
      user.is_active = false
    end
    user.save
    reset_session
    redirect_to root_path, notice: 'ありがとうございました。またのご利用を心よりお待ちしております。'
  end

  private

  def user_params
    params.require(:user).permit(:password)
  end
end
