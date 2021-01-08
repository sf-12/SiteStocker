# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admin/sessions'
  }
  devise_for :users, controllers: {
    sessions: 'user/sessions',
    passwords: 'user/passwords',
    registrations: 'user/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope module: 'user' do
    root 'homes#top'
    get 'home' => 'homes#home'
  end
end
