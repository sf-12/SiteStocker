# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/like.csv')
csv.each_with_index do |like, index|
  id = index + 1
  tweet_id = like[0]
  user_id = like[1]
  created_at = like[2]

  Like.seed(:id) do |s|
    s.id = id
    s.tweet_id = tweet_id
    s.user_id = user_id
    s.created_at = created_at
  end
end
