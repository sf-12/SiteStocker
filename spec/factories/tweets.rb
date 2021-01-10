# frozen_string_literal: true

FactoryBot.define do
  factory :tweet do
    text { 'おすすめです。' }
    is_opened { true }
  end
end
