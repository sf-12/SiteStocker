# frozen_string_literal: true

module TweetSupport
  # 新規投稿する
  def tweet_new
    find('#tweet_button_pc_js').click
    fill_in 'new_tweet_url__input', with: 'https://www.youtube.com/?gl=JP'
    fill_in 'new_tweet_text__input', with: 'おすすめです'
    find('.ui-autocomplete-input').set('動画')
    check 'new_tweet_is_opened__input'
    find('#new_tweet_button__test').click
  end
end

RSpec.configure do |config|
  config.include TweetSupport
end
