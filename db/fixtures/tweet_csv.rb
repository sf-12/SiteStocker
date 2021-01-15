# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/tweet.csv')
csv.each do |tweet|
  id = tweet[0]
  user_id = tweet[1]
  site_id = tweet[2]
  text = tweet[3]
  is_opened = tweet[4]
  created_at = tweet[5]

  Tweet.seed(:id) do |s|
    s.id = id
    s.user_id = user_id
    s.site_id = site_id
    s.text = text
    s.is_opened = is_opened
    s.created_at = created_at
  end
end
