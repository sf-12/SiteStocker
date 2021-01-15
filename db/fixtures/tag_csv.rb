# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/tag.csv')
csv.each do |tag|
  id = tag[0]
  name = tag[1]

  ActsAsTaggableOn::Tag.seed(:id) do |s|
    s.id = id
    s.name = name
  end
end
