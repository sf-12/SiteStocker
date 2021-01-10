# frozen_string_literal: true

class Site < ApplicationRecord
  # validation
  validates :url, presence: true

  # association
  has_many :tweets, dependent: :destroy
end
