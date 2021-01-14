# frozen_string_literal: true

class Tweet < ApplicationRecord
  # acts-as-taggable-onを使用する
  acts_as_taggable

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

  # ユーザーが投稿にコメントしているか調べる（true:している、false:していない）
  def commented_by?(user)
    comments.exists?(user_id: user.id)
  end

  # ユーザーが投稿にいいねしているか調べる（true:している、false:していない）
  def liked_by?(user)
    likes.exists?(user_id: user.id)
  end
end
