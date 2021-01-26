# frozen_string_literal: true

class User::CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @tweet = Tweet.find(params[:tweet_id])
    comment = current_user.comments.new(comment_params)
    comment.tweet_id = @tweet.id
    comment.save
  end

  def destroy
    @tweet = Tweet.find(params[:tweet_id])
    Comment.find_by(id: params[:id], tweet_id: params[:tweet_id]).destroy
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
