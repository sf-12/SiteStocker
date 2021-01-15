# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/site.csv')
csv.each do |site|
  id = site[0]
  url = site[1]

  Site.seed(:id) do |s|
    s.id = id
    s.url = url
  end
end
