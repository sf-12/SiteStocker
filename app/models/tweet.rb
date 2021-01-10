# frozen_string_literal: true

class Tweet < ApplicationRecord
  # validation
  validates :user_id, presence: true
  validates :site_id, presence: true
  validates :text, presence: true
  validates :is_opened, presence: true

  # association
  belongs_to :user
  belongs_to :site
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tweet_tags, dependent: :destroy
  has_many :tags, through: :tweet_tags

  # 投稿日時を日本語で返す
  def tweeted_at
    dw = %w[日 月 火 水 木 金 土]
    self.created_at.strftime("%Y/%m/%d(#{dw[self.created_at.wday]})")
  end
end
