# frozen_string_literal: true

Rails.application.routes.draw do
  # 管理者側 ログイン・ログアウト
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }

  # ユーザー側 新規登録・ログイン・ログアウト
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    passwords: 'user/passwords',
    registrations: 'user/registrations'
  }

  # 簡単ログイン
  devise_scope :user do
    post 'user/guest_sign_in' => 'user/sessions#new_guest'
  end

  # ユーザー側機能
  scope module: 'user' do
    root 'homes#top'
    get 'home' => 'homes#home'
    resources :tweets, only: %i[new create]
  end
end
