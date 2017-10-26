# frozen_string_literal: true

module FlashHelper
  def flash?
    flash.notice || flash.alert
  end
end
