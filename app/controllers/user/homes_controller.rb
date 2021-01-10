# frozen_string_literal: true

class User::HomesController < ApplicationController
  def home
    gon.linkpreview_key = ENV['LINK_PREVIEW_API_KEY']
    @tweets = Tweet.page(params[:page]).reverse_order
    gon.tweet_id_list = @tweets.ids
  end

  def about; end
end
