# frozen_string_literal: true

class Comment < ApplicationRecord
  # validation
  validates :user_id, presence: true
  validates :tweet_id, presence: true
  validates :text, presence: true

  # association
  belongs_to :user
  belongs_to :tweet
end
