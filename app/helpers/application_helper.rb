# frozen_string_literal: true

module ApplicationHelper
  # devise以外のコントローラからdeviseフォームにアクセス可能にする
  # -------------------------------------------------------
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  # -------------------------------------------------------
end
