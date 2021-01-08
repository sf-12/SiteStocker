# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { '鈴木太郎' }
    email { 'suzuki@taro.com' }
    password { 'suzuki' }
    text { 'よろしくお願いします。' }
    is_active { true }
  end
end
