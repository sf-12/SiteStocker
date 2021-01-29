# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/tagging.csv')
csv.each do |tagging|
  id = tagging[0]
  taggable_id = tagging[1]
  tag_id = tagging[2]

  ActsAsTaggableOn::Tagging.seed(:id) do |s|
    s.id = id
    s.taggable_id = taggable_id
    s.tag_id = tag_id
    s.taggable_type = 'tweet'
    s.context = 'tags'
  end
end
