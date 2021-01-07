# frozen_string_literal: true

class TweetTag < ApplicationRecord
  # relation
  belongs_to :tweet
  belongs_to :tag

  # validation
  validates :tweet_id, presence: true
  validates :tag_id, presence: true
end
