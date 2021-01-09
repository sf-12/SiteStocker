# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { '鈴木太郎' }
    sequence(:email) { |n| "suzuki#{n}@taro.com" }
    password { 'suzuki' }
    password_confirmation { 'suzuki' }
    text { 'よろしくお願いします。' }
    is_active { true }
  end
end
