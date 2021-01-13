# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # 作成日時を日本語で返す
  def created_at_ja
    dw = %w[日 月 火 水 木 金 土]
    self.created_at.strftime("%Y/%m/%d(#{dw[self.created_at.wday]}) %H:%M")
  end
end
