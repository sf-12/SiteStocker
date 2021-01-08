# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'バリデーション' do
    it '名前、メールアドレス、パスワード、自己紹介、退会フラグがあれば有効な状態であること' do
      user = FactoryBot.build(:user)
      expect(user).to be_valid
    end

    it '名前がなければ無効な状態であること' do
      user = FactoryBot.build(:user, name: nil)
      user.valid?
      expect(user.errors[:name]).to include('を入力してください')
    end

    it 'メールアドレスがなければ無効な状態であること' do
      user = FactoryBot.build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include('を入力してください')
    end

    it '重複したメールアドレスなら無効な状態であること' do
      FactoryBot.create(:user, email: 'aaa@aaa.com')
      user = FactoryBot.build(:user, email: 'aaa@aaa.com')
      user.valid?
      expect(user.errors[:email]).to include('はすでに存在します')
    end

    it 'パスワードがなければ無効な状態であること' do
      user = FactoryBot.build(:user, password: nil)
      user.valid?
      expect(user.errors[:password]).to include('を入力してください')
    end

    it 'パスワードが5文字以下であれば無効な状態であること' do
      user = FactoryBot.build(:user, password: '12345')
      user.valid?
      expect(user.errors[:password]).to include('は6文字以上で入力してください')
    end

    it 'パスワードが6文字以上であればエラーが出ないこと' do
      user = FactoryBot.build(:user, password: '123456')
      user.valid?
      expect(user.errors[:password]).not_to include('は6文字以上で入力してください')
    end

    it 'パスワードと確認用パスワードが一致していなければ無効な状態であること' do
      user = FactoryBot.build(:user, password: '123456', password_confirmation: '654321')
      user.valid?
      expect(user.errors[:password_confirmation]).to include('とパスワードの入力が一致しません')
    end

    it '自己紹介がなくても有効な状態であること' do
      user = FactoryBot.build(:user, text: nil)
      user.valid?
      expect(user.errors[:text]).not_to include('を入力してください')
    end

    it '退会フラグがなければ無効な状態であること' do
      user = FactoryBot.build(:user, is_active: nil)
      user.valid?
      expect(user.errors[:is_active]).to include('を入力してください')
    end
  end
end
