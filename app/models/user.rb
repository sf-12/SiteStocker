# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  # refile
  attachment :image

  # validation
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }, confirmation: true, allow_nil: true
  validates :password_confirmation, presence: true, allow_nil: true
  validates :is_active, inclusion: [true, false]

  # association
  has_many :ralationships, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tweets, dependent: :destroy

  # 簡単ログイン機能
  def self.guest_login
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.name = 'ゲストユーザー'
      user.is_active = true
      user.text = 'よろしくお願いします！'
      user.password = SecureRandom.urlsafe_base64
      user.password_confirmation = user.password
    end
    find_by!(email: 'guest@example.com') do |user|
      user.update(name: 'ゲストユーザー', is_active: 'true', text: 'よろしくお願いします！')
    end
  end

  # [devise用]パスワード入力なしで情報を更新する
  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end
end
