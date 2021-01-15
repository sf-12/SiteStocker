# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/comment.csv')
csv.each do |comment|
  id = comment[0]
  user_id = comment[1]
  tweet_id = comment[2]
  text = comment[3]
  created_at = comment[4]

  Comment.seed(:id) do |s|
    s.id = id
    s.user_id = user_id
    s.tweet_id = tweet_id
    s.text = text
    s.created_at = created_at
  end
end
