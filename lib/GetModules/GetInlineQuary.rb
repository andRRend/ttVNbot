require_relative 'GetParse'

def get_inline_quary bot, message
  include GetParse
  tt_list = get_parse_list(URL,LOGIN,PASSWORD)
  if tt_list==0
    markup = [[1, "Список инцидентов", @send_message]].map do |arr|
      Telegram::Bot::Types::InlineQueryResultArticle.new(id: arr[0], title: arr[1], input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(parse_mode:'HTML', message_text: "Инцидентов нет"))
    end
    bot.api.answer_inline_query(inline_query_id: message.id, results: markup)
  else
    i = 0
    @send_message = []
    tt_list.each do |tt|
      @send_message << "Номер: #{tt[0]}\nСтатус: #{tt[3]}\nЦелевой срок решения: #{tt[5]}\nПриоритет: #{tt[6]}\nКомментарий: #{tt[7]}\n"
      i = i + 1
    end
    @kb = []
    @kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: "Перейти к боту", switch_inline_query: "Перейти в чат с ботом")
    @kb_mp = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @kb)
    @send_message = @send_message * "\n"
    markup = [[1, "Список инцидентов", @send_message]].map do |arr|
      Telegram::Bot::Types::InlineQueryResultArticle.new(id: arr[0], title: arr[1], input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(parse_mode:'HTML', message_text: "Всего инцидентов #{i}:\n #{@send_message}", reply_markup: @kb_mp))
    end
    @send_message = nil
  end
  bot.api.answer_inline_query(inline_query_id: message.id, results: markup)
rescue
  bot.logger.error("### InlineQuerryError: #{$!.inspect}###")
end