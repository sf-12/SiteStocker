# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Tweets', type: :system do
  # あらかじめユーザーを作成しておく
  let(:user) { FactoryBot.create(:user) }

  describe '投稿する' do
    context '登録に成功する場合' do
      it 'ホーム画面に「投稿する」ボタンがある' do
        sign_in user
        visit '/home'
        expect(page).to have_content('投稿する')
      end

      it '「投稿する」を押すと投稿用ウィンドウが表示される' do
        sign_in user
        visit '/home'
        find('#tweet_button_pc_js').click
        expect(page).to have_content('投稿しよう')
      end

      it '投稿内容を記入して「投稿する」を押すとマイページに遷移する' do
        sign_in user
        visit '/home'
        # 新規投稿する
        tweet_new
        expect(page).to have_current_path user_path(user.id)
      end

      it 'マイページに投稿した記事が表示される' do
        sign_in user
        visit '/home'
        # 新規投稿する
        tweet_new
        expect(page).to have_content('おすすめです')
      end

      it 'ホーム画面のタイムラインに投稿した記事が表示される' do
        sign_in user
        visit '/home'
        # 新規投稿する
        tweet_new
        visit '/home'
        expect(page).to have_content('おすすめです')
      end
    end

    context '投稿に失敗する場合' do
      pending '投稿に失敗'
    end

    context '投稿を途中でやめる場合' do
      pending '投稿を途中でやめる'
    end
  end

  describe '投稿を編集する' do
    it '編集ボタンを押すと、投稿編集画面に遷移する' do
      sign_in user
      visit '/home'
      # 新規投稿する
      tweet_new
      find('#edit_tweet_path__test').click
      expect(page).to have_content('編集しよう')
    end

    it '編集すると投稿詳細ページに遷移する' do
      sign_in user
      visit '/home'
      # 新規投稿する
      tweet_new
      find('#edit_tweet_path__test').click
      # 投稿記事の編集
      fill_in 'edit_tweet_text__input', with: 'よく利用します'
      find('#edit_tweet_button__test').click
      expect(page).to have_current_path tweet_path(user.tweets.ids)
    end

    it '編集内容が反映されている' do
      sign_in user
      visit '/home'
      # 新規投稿する
      tweet_new
      find('#edit_tweet_path__test').click
      # 投稿記事の編集
      fill_in 'edit_tweet_text__input', with: 'よく利用します'
      find('#edit_tweet_button__test').click
      expect(page).to have_content('よく利用します')
    end
  end

  describe '投稿を削除する' do
    context '「本当に削除しますか？」で「はい」を押す場合' do
      it '投稿削除ボタンを押すと、マイページに遷移する' do
        sign_in user
        visit '/home'
        # 新規投稿する
        tweet_new
        # 削除ボタンを押す
        find('#delete_tweet_path__test').click
        # ダイアログでOKを選択する
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_current_path user_path(user.id)
      end

      it '投稿削除ボタンを押すと、投稿が削除される' do
        sign_in user
        visit '/home'
        # 新規投稿する
        tweet_new
        # 削除ボタンを押す
        find('#delete_tweet_path__test').click
        # ダイアログでOKを選択する
        page.driver.browser.switch_to.alert.accept
        expect(page).not_to have_content('おすすめです')
      end
    end

    context '「本当に削除しますか？」で「いいえ」を押す場合' do
      it 'ページが遷移しない' do
        sign_in user
        visit '/home'
        # 新規投稿する
        tweet_new
        # 削除ボタンを押す
        find('#delete_tweet_path__test').click
        # ダイアログでキャンセルを選択する
        page.driver.browser.switch_to.alert.dismiss
        expect(page).to have_current_path user_path(user.id)
      end

      it '投稿が削除されない' do
        sign_in user
        visit '/home'
        # 新規投稿する
        tweet_new
        # 削除ボタンを押す
        find('#delete_tweet_path__test').click
        # ダイアログでOKを選択する
        page.driver.browser.switch_to.alert.dismiss
        expect(page).to have_content('おすすめです')
      end
    end
  end
end
