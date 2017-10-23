module ApplicationHelper
  def join_messages(messages)
    messages = messages.join('; ') if messages.is_a? Array
    messages
  end
  def flashes
    flash.each do |type, msg|
      if msg.is_a? Array
        msg.each do |string|
          render partial: 'shared/flash_message', locals: { msg: string, type: type }
        end
      else
        render partial: 'shared/flash_message', locals: { msg: msg, type: type }
      end
    end
  end
end
