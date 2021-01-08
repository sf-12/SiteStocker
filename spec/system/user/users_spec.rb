# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe '新規ユーザー登録' do
    context '登録に成功する場合' do
      it '新規ユーザー登録画面に遷移する' do
        visit root_path
        click_button 'ユーザー登録'
        expect(page).to have_current_path '/users/sign_up'
      end

      it 'ユーザー登録するとホーム画面に遷移する' do
        visit new_user_registration_path
        fill_in 'new_user-name__input', with: '鈴木太郎'
        fill_in 'new_user-email__input', with: 'suzuki.taro@gmail.com'
        fill_in 'new_user-password__input', with: 'aaaaaa'
        fill_in 'new_user-password_confirmation__input', with: 'aaaaaa'
        click_button '登録する'
        expect(page).to have_current_path '/home'
      end
    end
  end

  describe 'ログイン' do
    context 'ログインに成功する場合' do
      # あらかじめユーザーを作成しておく
      let(:user) { FactoryBot.create(:user) }

      it 'ログイン画面に遷移する' do
        visit root_path
        click_button 'ログイン'
        expect(page).to have_current_path '/users/sign_in'
      end

      it 'ログインするとホーム画面に遷移する' do
        visit '/users/sign_in'
        fill_in 'log_in_user-email__input', with: user.email
        fill_in 'log_in_user-password__input', with: user.password
        click_button 'ログイン'
        expect(page).to have_current_path '/home'
      end
    end
  end

  describe 'ログアウト' do
    context 'ログアウトに成功する場合' do
      # あらかじめユーザーを作成しておく
      let(:user) { FactoryBot.create(:user) }

      it 'ヘッダーからログアウトできる' do
        # sign_in @user
        sign_in user
        visit '/home'
        click_link 'ログアウト'
        expect(page).to have_current_path '/'
      end
    end
  end
end
