# frozen_string_literal: true

module SettingSupport
  # パスワードを変更する
  # 引数1: 現在のパスワード
  # 引数2: 新しいパスワード
  # 引数3: 新しいパスワード(確認)
  def change_password(now_password, new_password, new_password_confirm)
    fill_in 'setting_now_password__input', with: now_password
    fill_in 'setting_new_password__input', with: new_password
    fill_in 'setting_new_password_confirm__input', with: new_password_confirm
    find('#setting_password_button__test').click
  end
end

RSpec.configure do |config|
  config.include SettingSupport
end
