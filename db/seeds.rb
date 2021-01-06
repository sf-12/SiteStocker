# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# 管理者
Admin.create!(
  email: 'admin1@test.com',
  password: 'aaaaaa'
)

# ユーザー
3.times do |n|
  User.create!(
    name: "user#{n + 1}",
    email: "user#{n + 1}@test.com",
    password: 'aaaaaa',
    image: File.open('./app/assets/images/user-default.png'),
    text: 'よろしくお願いします',
    is_active: true
  )
end

# リレーション
Relationship.create!(follower_id: 1, followee_id: 2)
Relationship.create!(follower_id: 1, followee_id: 3)
Relationship.create!(follower_id: 2, followee_id: 1)
Relationship.create!(follower_id: 3, followee_id: 2)

# ユーザー１ - 投稿１
Tweet.create!(user_id: 1, site_id: 1, text: 'おすすめです', is_opened: true)
Site.create!(url: 'https://www.amazon.co.jp/')
Tag.create!(name: '通販')
Tag.create!(name: '音楽')
Tag.create!(name: '映画')
TweetSite.create!(tweet_id: 1, site_id: 1)
TweetTag.create!(tweet_id: 1, tag_id: 1)
TweetTag.create!(tweet_id: 1, tag_id: 2)
TweetTag.create!(tweet_id: 1, tag_id: 3)
Like.create!(user_id: 2, tweet_id: 1)
Comment.create!(user_id: 2, tweet_id: 1, text: '買い物するのに便利です')

# ユーザー１ - 投稿2
Tweet.create!(user_id: 1, site_id: 2, text: 'これもおすすめです', is_opened: true)
Site.create!(url: 'https://qiita.com/')
Tag.create!(name: '学習')
Tag.create!(name: 'アウトプット')
Tag.create!(name: 'プログラミング')
TweetSite.create!(tweet_id: 2, site_id: 2)
TweetTag.create!(tweet_id: 2, tag_id: 4)
TweetTag.create!(tweet_id: 2, tag_id: 5)
TweetTag.create!(tweet_id: 2, tag_id: 6)
Like.create!(user_id: 2, tweet_id: 2)
Like.create!(user_id: 3, tweet_id: 2)
Comment.create!(user_id: 3, tweet_id: 2, text: '良い記事がたくさんありました')
