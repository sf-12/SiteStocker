# frozen_string_literal: true

class User::LikesController < ApplicationController
  def create
    tweet = Tweet.find(params[:tweet_id])
    like = current_user.likes.new(tweet_id: tweet.id)
    like.save
    redirect_to request.referer
  end

  def destroy
    tweet = Tweet.find(params[:tweet_id])
    like = current_user.likes.find_by(tweet_id: tweet.id)
    like.destroy
    redirect_to request.referer
  end
end
