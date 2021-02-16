# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/comment.csv')
csv.each_with_index do |comment, index|
  id = index + 1
  tweet_id = comment[0]
  user_id = comment[1]
  text = comment[2]
  created_at = comment[3]

  Comment.seed(:id) do |s|
    s.id = id
    s.tweet_id = tweet_id
    s.user_id = user_id
    s.text = text
    s.created_at = created_at
  end
end
