module Login
  def login message, bot
    if File.exist?("lib/users/#{message.from.id}")
      return message
    elsif message.text == "register"
      registration message, bot
      bot.logger.info("#{message.from.id} ### Register OK ###")
      return
    else
      return 0
    end
  end

  def registration message, bot
    File.new("lib/users/#{message.from.id}", "a+")
    File.open("lib/users/#{message.from.id}", "a"){|file| file.write "#{message.from.first_name} #{message.from.last_name},0"}
    bot.api.send_message(chat_id: message.chat.id, text: "Регистрация прошла успешно, приятного пользования")
    return message
  end
end