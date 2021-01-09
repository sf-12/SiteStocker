# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Site, type: :model do
  describe 'バリデーション' do
    it 'サイトURLがあれば有効な状態であること' do
      site = FactoryBot.build(:site)
      expect(site).to be_valid
    end

    it 'サイトURLがなければ無効な状態であること' do
      site = FactoryBot.build(:site, url: nil)
      site.valid?
      expect(site.errors[:url]).to include('を入力してください')
    end
  end
end
