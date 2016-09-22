module ApplicationHelper

  # for gems that do not use flash keys that are bootstrap classes
  BOOTSTRAP_CONTEXTUAL_CLASSES = [
    "info",
    "warning",
    "success",
    "danger"
  ]

  FLASH_TRANSLATION = {
    "notice" => "info"
  }

  def class_for_bootstrap(flash_message_type)
    if BOOTSTRAP_CONTEXTUAL_CLASSES.include? flash_message_type
      return flash_message_type
    elsif r = FLASH_TRANSLATION[flash_message_type]
      return r
    else
      return "info"
    end
  end
end
