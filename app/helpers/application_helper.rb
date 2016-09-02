module ApplicationHelper

  # for gems that do not use flash keys that are bootstrap classes
  def class_for_bootstrap(flash_message_type)
    if [
      "notice",
    ].include? flash_message_type
      return "info"
    else
      return flash_message_type
    end
  end
end
