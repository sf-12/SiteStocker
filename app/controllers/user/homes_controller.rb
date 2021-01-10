# frozen_string_literal: true

class User::HomesController < ApplicationController
  def home
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']
    gon.tweet_id_list = Tweet.all.ids
    @tweets = Tweet.all
  end

  def about; end
end
