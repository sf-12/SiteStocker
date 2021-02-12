# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'System Passwords', type: :system do
  describe 'パスワード変更に成功する場合' do
    context 'ページ遷移' do
      # あらかじめユーザーを作成しておく
      let(:user) { FactoryBot.create(:user) }

      it 'マイページに遷移する' do
        sign_in user
        visit users_setting_path
        # パスワードを変更する
        change_password(user.password, 'newpassword', 'newpassword')
        expect(page).to have_current_path user_path(user.id)
      end
    end

    context 'フラッシュメッセージが表示される' do
      # あらかじめユーザーを作成しておく
      let(:user) { FactoryBot.create(:user) }

      it 'パスワードを変更しました' do
        sign_in user
        visit users_setting_path
        # パスワードを変更する
        change_password(user.password, 'newpassword', 'newpassword')
        expect(page).to have_content 'パスワードを変更しました'
      end
    end

    context '再ログイン' do
      # あらかじめユーザーを作成しておく
      let(:user) { FactoryBot.create(:user) }

      it '変更前のパスワードではログインできない' do
        sign_in user
        visit users_setting_path
        # パスワードを変更する
        change_password(user.password, 'newpassword', 'newpassword')
        # ログアウトする
        find('#header_logout_test').click
        # ログインする
        click_link 'ログイン'
        fill_in 'log_in_user_email__input', with: user.email
        fill_in 'log_in_user_password__input', with: 'suzuki'
        click_button 'ログイン'
        expect(page).not_to have_current_path '/home'
      end

      it '変更後のパスワードでログインできる' do
        sign_in user
        visit users_setting_path
        # パスワードを変更する
        change_password(user.password, 'newpassword', 'newpassword')
        # ログアウトする
        find('#header_logout_test').click
        # ログインする
        click_link 'ログイン'
        fill_in 'log_in_user_email__input', with: user.email
        fill_in 'log_in_user_password__input', with: 'newpassword'
        click_button 'ログイン'
        expect(page).to have_current_path '/home'
      end
    end
  end

  describe 'パスワード変更に失敗する場合' do
    context '現在のパスワードが間違っている場合' do
      # あらかじめユーザーを作成しておく
      let(:user) { FactoryBot.create(:user) }

      it '設定ページにリダイレクトされる' do
        sign_in user
        visit users_setting_path
        # パスワードを変更する
        change_password('wrongpassword', 'newpassword', 'newpassword')
        expect(page).to have_current_path user_path(user.id)
      end

      it 'フラッシュメッセージが表示される' do
        sign_in user
        visit users_setting_path
        # パスワードを変更する
        change_password('wrongpassword', 'newpassword', 'newpassword')
        expect(page).to have_content '現在のパスワードは不正な値です'
      end
    end

    context '新しいパスワードの文字数が6文字に満たない場合' do
      # あらかじめユーザーを作成しておく
      let(:user) { FactoryBot.create(:user) }

      it '設定ページにリダイレクトされる' do
        sign_in user
        visit users_setting_path
        # パスワードを変更する
        change_password(user.password, 'new', 'new')
        expect(page).to have_current_path user_path(user.id)
      end

      it 'フラッシュメッセージが表示される' do
        sign_in user
        visit users_setting_path
        # パスワードを変更する
        change_password(user.password, 'new', 'new')
        expect(page).to have_content 'パスワードは6文字以上で入力してください'
      end
    end

    context '新しいパスワードと新しいパスワード（確認）が異なる場合' do
      # あらかじめユーザーを作成しておく
      let(:user) { FactoryBot.create(:user) }

      it '設定ページにリダイレクトされる' do
        sign_in user
        visit users_setting_path
        # パスワードを変更する
        change_password('wrongpassword', 'newpassword', 'newpassword')
        expect(page).to have_current_path user_path(user.id)
      end

      it 'フラッシュメッセージが表示される' do
        sign_in user
        visit users_setting_path
        # パスワードを変更する
        change_password('wrongpassword', 'newpassword', 'passwordnew')
        expect(page).to have_content 'パスワード（確認）とパスワードの入力が一致しません'
      end
    end
  end
end
