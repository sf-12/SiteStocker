# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/user.csv')
csv.each do |user|
  id = user[0]
  name = user[1]
  email = user[2]
  text = user[3]
  is_active = user[4]
  created_at = user[5]

  User.seed(:id) do |s|
    s.id = id
    s.name = name
    s.email = email
    s.text = text
    s.is_active = is_active
    s.created_at = created_at
    s.password = ENV['USER_PASSWORD']
  end
end
