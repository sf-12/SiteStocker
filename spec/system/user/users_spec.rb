# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe '新規ユーザー登録' do
    context '登録に成功する場合' do
      it '新規ユーザー登録画面に遷移する' do
        visit root_path
        click_link 'ユーザー登録'
        expect(page).to have_current_path '/users/sign_up'
      end

      it 'ユーザー登録するとホーム画面に遷移する' do
        visit new_user_registration_path
        fill_in 'new_user_name__input', with: '鈴木太郎'
        fill_in 'new_user_email__input', with: 'suzuki.taro@gmail.com'
        fill_in 'new_user_password__input', with: 'aaaaaa'
        fill_in 'new_user_password_confirmation__input', with: 'aaaaaa'
        click_button '登録する'
        expect(page).to have_current_path '/home'
      end

      it 'ユーザー登録成功のフラッシュメッセージが表示される' do
        visit new_user_registration_path
        fill_in 'new_user_name__input', with: '鈴木太郎'
        fill_in 'new_user_email__input', with: 'suzuki.taro@gmail.com'
        fill_in 'new_user_password__input', with: 'aaaaaa'
        fill_in 'new_user_password_confirmation__input', with: 'aaaaaa'
        click_button '登録する'
        expect(page).to have_content 'ユーザー登録しました！　SiteStockerへようこそ！'
      end
    end
  end

  describe 'ログイン' do
    context 'ログインに成功する場合' do
      # あらかじめユーザーを作成しておく
      let(:user) { FactoryBot.create(:user) }

      it 'ログイン画面に遷移する' do
        visit root_path
        click_link 'ログイン'
        expect(page).to have_current_path '/users/sign_in'
      end

      it 'ログインするとホーム画面に遷移する' do
        visit '/users/sign_in'
        fill_in 'log_in_user_email__input', with: user.email
        fill_in 'log_in_user_password__input', with: user.password
        click_button 'ログイン'
        expect(page).to have_current_path '/home'
      end

      it 'ログイン成功のフラッシュメッセージが表示される' do
        visit '/users/sign_in'
        fill_in 'log_in_user_email__input', with: user.email
        fill_in 'log_in_user_password__input', with: user.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
      end
    end
  end

  describe 'ログアウト' do
    # あらかじめユーザーを作成しておく
    let(:user) { FactoryBot.create(:user) }

    it 'ヘッダーからログアウトできる' do
      sign_in user
      visit '/home'
      find('#header_logout_test').click
      expect(page).to have_current_path '/'
    end

    it 'ログアウト成功のフラッシュメッセージが表示される' do
      sign_in user
      visit '/home'
      find('#header_logout_test').click
      expect(page).to have_content 'ログアウトしました'
    end
  end

  describe '簡単ログイン' do
    it 'トップページから簡単ログインできる' do
      visit root_path
      click_link '簡単ログイン'
      expect(page).to have_current_path '/home'
    end

    it '新規ユーザー登録ページから簡単ログインできる' do
      visit new_user_registration_path
      click_link '簡単ログイン'
      expect(page).to have_current_path '/home'
    end

    it 'ログインページから簡単ログインできる' do
      visit new_user_session_path
      click_link '簡単ログイン'
      expect(page).to have_current_path '/home'
    end
  end

  describe 'プロフィール変更' do
    context '自分のプロフィール画面の場合' do
      # あらかじめユーザーを作成しておく
      let(:user) { FactoryBot.create(:user) }

      it 'プロフィール変更ボタンがある' do
        sign_in user
        visit user_path(user.id)
        expect(page).to have_content 'プロフィール編集'
      end

      it 'プロフィール変更ボタンをおすとウィンドウが表示される' do
        sign_in user
        visit user_path(user.id)
        find('#profile_button_js').click
        expect(page).to have_content '編集しよう'
      end

      it 'プロフィール変更するとプロフィールページに遷移する' do
        sign_in user
        visit user_path(user.id)
        find('#profile_button_js').click
        # ユーザー名の編集
        fill_in 'update_profile_name__input', with: '田中次郎'
        find('#edit_user_button__test').click
        expect(page).to have_current_path user_path(user.id)
      end

      it 'プロフィールが変更されている' do
        sign_in user
        visit user_path(user.id)
        find('#profile_button_js').click
        # ユーザー名の編集
        fill_in 'update_profile_name__input', with: '田中次郎'
        find('#edit_user_button__test').click
        expect(page).to have_content '田中次郎'
      end
    end

    context '他人のプロフィール画面の場合' do
      # あらかじめユーザーを作成しておく
      let(:user) { FactoryBot.create(:user) }
      let(:another_user) { FactoryBot.create(:user) }

      it 'プロフィール変更ボタンがない' do
        sign_in user
        visit user_path(another_user.id)
        expect(page).not_to have_content 'プロフィール編集'
      end
    end
  end
end
