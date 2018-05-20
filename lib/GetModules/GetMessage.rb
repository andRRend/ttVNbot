require_relative 'GetParse'

def get_message bot, message
  if message.text=="/list"
    include GetParse
    tt_list = get_parse_list(URL,LOGIN,PASSWORD)
    if tt_list==0
      bot.api.send_message(chat_id: message.chat.id, text: 'Инцидентов нет')
    else
      i = 0
      @kb = []
      tt_list.each do |tt|
        @kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: "Инц.:#{tt[0]}, Пр.:#{tt[6]}", callback_data: "#{tt[0]}")
        i = i+1
      end
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @kb)
      bot.api.send_message(chat_id: message.chat.id, text: "Всего инцидентов: #{i}", reply_markup: markup)
    end
  elsif message.text=='/report'
    @tt_kb = []
    @tt_kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: "Перейти", callback_data: "tt")
    tt_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @tt_kb)
    bot.api.send_message(chat_id: message.chat.id, text: "Постраничный вывод инцидентов", reply_markup: tt_markup)
  elsif message.text=='/start'
    bot.api.send_message(chat_id: message.chat.id, text: "Привет, #{message.from.first_name}, я могу выводить отчет об инцидентах из системы TTMS, воспользуйся коммандой /help - список комманд для управления")
  elsif message.text=='/help'
    bot.api.send_message(chat_id: message.chat.id, text: "Список комманд для управления\n/report - Вывод подробного отчета\n/list - Вывод списка\n@ttVNbot-->Список инцидентов(из любого чата) - вывод подробного отчета\nhttps://github.com/threepwoodg/ttVNbot")
  elsif message.text.include? "#"
    string = message.text
    tt_number = string[15,7]
    comment = string[23..-1]
    tthash = Hash["tt_number", tt_number, "user", message.from.username, "comment" , comment]
    File.open("lib/tt/#{tt_number}", 'w') {|file| file.write tthash.to_json}
    bot.api.send_message(chat_id: message.chat.id, text: "К инциденту: #{tt_number}, добавлен комментатрий: #{comment}")
  else
    bot.api.send_message(chat_id: message.chat.id, text: "Не знаю такой комманды! Список комманд для управления:\n/report - Вывод подробного отчета\n/list - Вывод списка\n/help - Справка")
  end
  rescue
  bot.api.send_message(chat_id: message.chat.id, text: "Что-то пошло не так :( Нет связи с сервером TTMS, либо неверный формат данных, попробуйте снова либо сообщите разработчику, возможно он все починит ;)")
  bot.logger.error("### MessageError: #{$!.inspect} ###")
end