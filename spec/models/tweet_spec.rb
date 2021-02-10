# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Tweet, type: :model do
  describe 'バリデーション' do
    it 'ユーザーIDとサイトIDと投稿記事とタイムライン公開フラグがあれば有効な状態であること' do
      user = FactoryBot.create(:user)
      site = FactoryBot.create(:site)
      tweet = FactoryBot.build(:tweet, user_id: user.id, site_id: site.id)
      expect(tweet).to be_valid
    end

    it 'ユーザーIDがなければ無効な状態であること' do
      site = FactoryBot.create(:site)
      tweet = FactoryBot.build(:tweet, user_id: nil, site_id: site.id)
      tweet.valid?
      expect(tweet.errors[:user_id]).to include('を入力してください')
    end

    it 'サイトIDがなければ無効な状態であること' do
      user = FactoryBot.create(:user)
      tweet = FactoryBot.build(:tweet, user_id: user.id, site_id: nil)
      tweet.valid?
      expect(tweet.errors[:site_id]).to include('を入力してください')
    end

    it '投稿記事がなければ無効な状態であること' do
      user = FactoryBot.create(:user)
      site = FactoryBot.create(:site)
      tweet = FactoryBot.build(:tweet, user_id: user.id, site_id: site.id, text: nil)
      tweet.valid?
      expect(tweet.errors[:text]).to include('を入力してください')
    end

    it 'タイムライン公開フラグがなければ無効な状態であること' do
      user = FactoryBot.create(:user)
      site = FactoryBot.create(:site)
      tweet = FactoryBot.build(:tweet, user_id: user.id, site_id: site.id, is_opened: nil)
      tweet.valid?
      expect(tweet.errors[:is_opened]).to include('は一覧にありません')
    end
  end

  describe 'メソッド' do
    context 'commented_by?(user)' do
      it 'userが投稿にコメントしているとき、trueを返すこと' do
        tweet_user = FactoryBot.create(:user)
        comment_user = FactoryBot.create(:user)
        site = FactoryBot.create(:site)
        tweet = FactoryBot.create(:tweet, user_id: tweet_user.id, site_id: site.id)
        FactoryBot.create(:comment, user_id: comment_user.id, tweet_id: tweet.id)
        expect(tweet.commented_by?(comment_user)).to eq true
      end

      it 'userが投稿にコメントしていないとき、falseを返すこと' do
        tweet_user = FactoryBot.create(:user)
        comment_user = FactoryBot.create(:user)
        not_comment_user = FactoryBot.create(:user)
        site = FactoryBot.create(:site)
        tweet = FactoryBot.create(:tweet, user_id: tweet_user.id, site_id: site.id)
        FactoryBot.create(:comment, user_id: comment_user.id, tweet_id: tweet.id)
        expect(tweet.commented_by?(not_comment_user)).to eq false
      end
    end

    context 'liked_by?(user)' do
      it 'userが投稿にいいねしているとき、trueを返すこと' do
        tweet_user = FactoryBot.create(:user)
        like_user = FactoryBot.create(:user)
        site = FactoryBot.create(:site)
        tweet = FactoryBot.create(:tweet, user_id: tweet_user.id, site_id: site.id)
        FactoryBot.create(:like, user_id: like_user.id, tweet_id: tweet.id)
        expect(tweet.liked_by?(like_user)).to eq true
      end

      it 'userが投稿にいいねしていないとき、falseを返すこと' do
        tweet_user = FactoryBot.create(:user)
        like_user = FactoryBot.create(:user)
        not_like_user = FactoryBot.create(:user)
        site = FactoryBot.create(:site)
        tweet = FactoryBot.create(:tweet, user_id: tweet_user.id, site_id: site.id)
        FactoryBot.create(:like, user_id: like_user.id, tweet_id: tweet.id)
        expect(tweet.liked_by?(not_like_user)).to eq false
      end
    end
  end
end
