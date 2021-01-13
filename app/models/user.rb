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
  has_many :relationships, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :tweets, dependent: :destroy

  # フォロー機能------------------------------------------------
  # フォローする側のRelationshipをfollow_relationshipsと定義
  # rubocop:disable Rails/InverseOf
  has_many  :follow_relationships,
            class_name: 'Relationship',
            foreign_key: 'follower_id',
            dependent: :destroy
  # rubocop:enable Rails/InverseOf

  # @user.followinhgsで、ユーザーがフォローしている人の一覧を出す
  has_many :followings, through: :follow_relationships, source: :followee

  # フォローする側のRelationshipをfollowd_relationshipsと定義
  # rubocop:disable Rails/InverseOf
  has_many  :followed_relationships,
            class_name: 'Relationship',
            foreign_key: 'followee_id',
            dependent: :destroy
  # rubocop:enable Rails/InverseOf

  # @user.followedsで、ユーザーをフォローしている人の一覧を出す
  has_many :followeds, through: :followed_relationships, source: :follower
  # ----------------------------------------------------------

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

  # ユーザーをフォローする
  def follow(user_id)
    self.follow_relationships.create(followee_id: user_id)
  end

  # ユーザーをフォロー解除する
  def unfollow(user_id)
    self.follow_relationships.find_by(followee_id: user_id).destroy
  end

  # ユーザーをフォローしているか調べる（true:している、false:していない）
  def following?(user)
    self.followings.include?(user)
  end
end
