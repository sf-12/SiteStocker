# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # 検索ロジック用
  scope :span_month, -> { where(created_at: Time.now.in_time_zone.all_month) }
  scope :span_year, -> { where(created_at: Time.now.in_time_zone.all_year) }

  # 作成日時を日本語で返す
  def created_at_ja
    dw = %w[日 月 火 水 木 金 土]
    self.created_at.strftime("%Y/%m/%d(#{dw[self.created_at.wday]}) %H:%M")
  end

  # 更新日時を日本語で返す
  def updated_at_ja
    dw = %w[日 月 火 水 木 金 土]
    self.updated_at.strftime("%Y/%m/%d(#{dw[self.updated_at.wday]}) %H:%M")
  end
end
