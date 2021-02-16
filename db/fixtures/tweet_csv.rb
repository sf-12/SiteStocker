# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/tweet.csv')
csv.each_with_index do |tweet, index|
  id = index + 1
  user_id = tweet[0]
  site_id = tweet[1]
  text = tweet[2]
  is_opened = tweet[3]
  created_at = tweet[4]

  Tweet.seed(:id) do |s|
    s.id = id
    s.user_id = user_id
    s.site_id = site_id
    s.text = text
    s.is_opened = is_opened
    s.created_at = created_at
  end
end
