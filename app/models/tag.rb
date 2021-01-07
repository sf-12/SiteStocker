# frozen_string_literal: true

class Tag < ApplicationRecord
  # relation
  has_many :tweet_tags, dependent: :destroy

  # validation
  validates :name, presence: true
end
