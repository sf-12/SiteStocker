# frozen_string_literal: true

Admin.seed(:id) do |s|
  s.id = 1
  s.email = ENV['ADMIN_EMAIL']
  s.password = ENV['ADMIN_PASSWORD']
end
