module FlashHelper
  def has_flash?
    flash.notice || flash.alert
  end
end
