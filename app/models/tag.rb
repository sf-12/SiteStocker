# frozen_string_literal: true

class Tag < ApplicationRecord
  # validation
  validates :name, presence: true

  # association
  has_many :tweet_tags, dependent: :destroy
end
