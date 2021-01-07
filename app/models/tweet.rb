# frozen_string_literal: true

class Tweet < ApplicationRecord
  # relation
  belongs_to :user
  belongs_to :site
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tweet_tags, dependent: :destroy
  has_many :tags, through: :tweet_tags

  # validation
  validates :user_id, presence: true
  validates :site_id, presence: true
  validates :text, presence: true
  validates :is_opened, presence: true
end
