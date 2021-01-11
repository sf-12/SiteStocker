# frozen_string_literal: true

class TweetTag < ApplicationRecord
  # validation
  validates :tweet_id, presence: true
  validates :tag_id, presence: true

  # association
  belongs_to :tweet
  belongs_to :tag
end
