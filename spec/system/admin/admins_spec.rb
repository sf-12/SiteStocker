# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admins', type: :system do
  # あらかじめ管理者を作成しておく
  let(:admin) { FactoryBot.create(:admin) }
  let(:user) { FactoryBot.create(:user) }

  describe 'ログイン' do
    context 'ログインに成功する場合' do
      it 'ログインするとホーム画面に遷移する' do
        visit new_admin_session_path
        fill_in 'log_in_admin_email__input', with: admin.email
        fill_in 'log_in_admin_password__input', with: admin.password
        click_button 'ログイン'
        expect(page).to have_current_path admin_path
      end

      it 'ログイン成功のフラッシュメッセージが表示される' do
        visit new_admin_session_path
        fill_in 'log_in_admin_email__input', with: admin.email
        fill_in 'log_in_admin_password__input', with: admin.password
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました'
      end
    end

    context 'ログインに失敗する場合（メールアドレス間違い）' do
      it 'ログイン画面にリダイレクトする' do
        visit new_admin_session_path
        fill_in 'log_in_admin_email__input', with: 'email@email.com'
        fill_in 'log_in_admin_password__input', with: admin.password
        click_button 'ログイン'
        expect(page).to have_current_path new_admin_session_path
      end

      it 'フラッシュメッセージが表示される' do
        visit new_admin_session_path
        fill_in 'log_in_admin_email__input', with: 'email@email.com'
        fill_in 'log_in_admin_password__input', with: admin.password
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレスまたはパスワードが違います'
      end
    end

    context 'ログインに失敗する場合（パスワード間違い）' do
      it 'ログイン画面にリダイレクトする' do
        visit new_admin_session_path
        fill_in 'log_in_admin_email__input', with: admin.email
        fill_in 'log_in_admin_password__input', with: 'aaaaaa'
        click_button 'ログイン'
        expect(page).to have_current_path new_admin_session_path
      end

      it 'フラッシュメッセージが表示される' do
        visit new_admin_session_path
        fill_in 'log_in_admin_email__input', with: admin.email
        fill_in 'log_in_admin_password__input', with: 'aaaaaa'
        click_button 'ログイン'
        expect(page).to have_content 'メールアドレスまたはパスワードが違います'
      end
    end
  end

  describe 'ログアウト' do
    it 'ヘッダーからログアウトできる' do
      sign_in admin
      visit admin_path
      find('#admin_header_logout_test').click
      expect(page).to have_current_path new_admin_session_path
    end

    it 'ログアウト成功のフラッシュメッセージが表示される' do
      sign_in admin
      visit admin_path
      find('#admin_header_logout_test').click
      expect(page).to have_content 'ログアウトしました'
    end
  end

  describe 'ユーザー側ログアウト' do
    context 'ユーザーログイン中に管理者側ログイン画面にアクセスした場合' do
      it 'ユーザーアカウントはサインアウトしたというフラッシュメッセージが表示される' do
        sign_in user
        visit admin_path
        expect(page).to have_content 'ユーザー側サイトはサインアウトしました'
      end
    end
  end
end
