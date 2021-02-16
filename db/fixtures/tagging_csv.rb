# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/tagging.csv')
csv.each_with_index do |tagging, index|
  id = index + 1
  taggable_id = tagging[0]
  tag_id = tagging[1]

  ActsAsTaggableOn::Tagging.seed(:id) do |s|
    s.id = id
    s.taggable_id = taggable_id
    s.tag_id = tag_id
    s.taggable_type = 'tweet'
    s.context = 'tags'
  end
end
