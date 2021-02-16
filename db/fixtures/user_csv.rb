# frozen_string_literal: true

require 'csv'

csv = CSV.read('db/fixtures/user.csv')
csv.each_with_index do |user, index|
  id = index + 1
  name = user[0]
  email = user[1]
  text = user[2]
  is_active = user[3]
  created_at = user[4]

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
