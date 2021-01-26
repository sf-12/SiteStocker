# frozen_string_literal: true

class Admin::CommentsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @comments = Comment.all.page(params[:page]).per(10)
  end

  def show
    @comment = Comment.find(params[:id])
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    comment = Comment.find(params[:id])
    if comment.update(comment_params)
      redirect_to admin_comments_path
    else
      render :edit
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :tweet_id, :text)
  end
end
