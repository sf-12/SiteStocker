# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.4', '>= 5.2.4.4'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4', '< 0.6.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'mini_racer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
# gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# === 追加 ===
# 認証機能に使用
gem 'devise'
# Bootstrap
gem 'bootstrap'
# jQuery
gem 'jquery-rails'
# ページネーション機能
gem 'kaminari'
# アイコンの表示
gem 'font-awesome-sass'
# 環境変数の管理
gem 'dotenv-rails'
# jsファイルで環境変数を使用できるようにする
gem 'gon'
# エラーメッセージの日本語化
gem 'rails-i18n'
# warning回避のためRubyバージョンに合わせる
gem 'parser', '< 2.7.2.0'
# 画像のアップロードに使用
gem 'refile', require: 'refile/rails', github: 'manfe/refile'
# アップロードした画像のリサイズに使用
gem 'refile-mini_magick'
# タグ機能を実装
gem 'acts-as-taggable-on'
# タグUI用jQueryプラグインTag-itの使用に必要
gem 'jquery-ui-rails'
# 初期データ作成に使用
gem 'seed-fu'
# S3へのアクセス
gem 'refile-s3', github: 'refile/refile-s3', ref: '768d60d4e5e5e6a00a874767018ff8e31b1da3cd'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # 自動デプロイ
  gem 'capistrano'
  gem 'capistrano3-puma'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'

  # rails c を見やすくする
  gem 'awesome_print'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'

  # RuboCop関連
  gem 'rubocop'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
  gem 'rubocop-rspec'
end

group :test do
  # RSpec関連
  gem 'capybara'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  # System Spec用にChromeDriverを導入する
  gem 'webdrivers'
  # カバレッジを表示
  gem 'simplecov'
end
