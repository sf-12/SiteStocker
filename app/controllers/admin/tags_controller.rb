# frozen_string_literal: true

class Admin::TagsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @tags = ActsAsTaggableOn::Tag.all.page(params[:page]).per(10)
  end

  def show
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
    @tag_created_at = created_at_ja(@tag)
    @tag_updated_at = updated_at_ja(@tag)
  end

  def edit
    @tag = ActsAsTaggableOn::Tag.find(params[:id])
  end

  def update
    tag = ActsAsTaggableOn::Tag.find(params[:id])
    if tag.update(tag_params)
      redirect_to admin_tags_path
    else
      render :edit
    end
  end

  private

  def tag_params
    params.require(:acts_as_taggable_on_tag).permit(:name)
  end

  # 作成日時を日本語で返す
  def created_at_ja(tag)
    dw = %w[日 月 火 水 木 金 土]
    tag.created_at.strftime("%Y/%m/%d(#{dw[tag.created_at.wday]}) %H:%M")
  end

  # 更新日時を日本語で返す
  def updated_at_ja(tag)
    dw = %w[日 月 火 水 木 金 土]
    tag.updated_at.strftime("%Y/%m/%d(#{dw[tag.updated_at.wday]}) %H:%M")
  end
end
