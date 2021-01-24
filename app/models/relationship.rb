# frozen_string_literal: true

class Relationship < ApplicationRecord
  # validation
  validates :follower_id, uniqueness: { scope: %I[follower_id followee_id] } # 二重にフォローすることはできない
  validates :follower_id, presence: true
  validates :followee_id, presence: true

  # association
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'
end
