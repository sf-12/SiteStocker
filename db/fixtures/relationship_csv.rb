# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/relationship.csv')
csv.each do |relationship|
  id = relationship[0]
  follower_id = relationship[1]
  followee_id = relationship[2]

  Relationship.seed(:id) do |s|
    s.id = id
    s.follower_id = follower_id
    s.followee_id = followee_id
  end
end
