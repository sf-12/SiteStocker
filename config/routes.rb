# frozen_string_literal: true

Rails.application.routes.draw do
  # 管理者側 ログイン・ログアウト
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }

  # 管理者側機能
  namespace :admin do
    get '/' => 'homes#home'
    resources :users, only: %i[index show edit update]
    resources :tweets, only: %i[index show edit update]
    resources :tags, only: %i[index show edit update]
    resources :comments, only: %i[index show edit update]
  end

  # ユーザー側 新規登録・ログイン・ログアウト
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    passwords: 'user/passwords',
    registrations: 'user/registrations'
  }

  # ユーザー側 簡単ログイン
  devise_scope :user do
    post 'user/guest_sign_in' => 'user/sessions#new_guest'
  end

  # ユーザー側機能
  scope module: 'user' do
    root 'homes#top'
    get 'home' => 'homes#home'
    get 'about' => 'homes#about'
    resources :tweets, only: %i[new create show edit update destroy] do
      resources :comments, only: %i[create destroy]
      resource :likes, only: %i[create destroy]
    end
    get 'users/setting' => 'users#setting'
    resources :users, only: %i[show destroy] do
      resources :relationships, only: %i[create destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    get 'searches/result', to: 'searches#result'
  end
end
