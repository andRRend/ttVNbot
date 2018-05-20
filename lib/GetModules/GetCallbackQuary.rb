require_relative 'GetParse'
require 'csv'

def get_callback_quary bot, message
  if message.data == "tt"
    #begin
      include GetParse
      @tt_tt_list = get_parse_list(URL,LOGIN,PASSWORD)
      @tt = 0
    #rescue
    #    bot.api.send_message(chat_id: message.from.id, text: "Что-то пошло не так :( попробуйте снова либо сообщите разработчику, возможно он все починит ;)")
    #    bot.logger.error("### CallbackQuarryError: #{$!.inspect} ###")
    #end
    #begin
      if @tt_tt_list.size == 0
        bot.api.send_message(chat_id: message.from.id, text: 'Инцидентов нет')
      elsif @tt_tt_list.size == 1
        p @tt
        tt_kb = []
        tt_kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: "##{@tt_tt_list[@tt][0]}", switch_inline_query_current_chat: "##{@tt_tt_list[@tt][0]}")
        tt_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: tt_kb)
        bot.api.editMessageText(chat_id: message.from.id, message_id: message.message.message_id, parse_mode: 'HTML', text: "Инцидент #{@tt+1} из #{@tt_tt_list.size}\n Информация по инциденту <a href=\"h@ttps://172.21.231.235/@ttms/ticket?id=#{@tt_tt_list[@tt][0]}\">#{@tt_tt_list[@tt][0]}</a>: <a href=\"h@ttps://172.21.231.235/@ttms/@ttedit?id=#{@tt_tt_list[@tt][0]}&block_id=1,2,3\">Решить</a>\nТип: #{@tt_tt_list[@tt][1]}\nПодчинение: #{@tt_tt_list[@tt][2]}\nСтатус: #{@tt_tt_list[@tt][3]}\nЦелевой срок решения: #{@tt_tt_list[@tt][5]}\nПриоритет: #{@tt_tt_list[@tt][6]}\nОписание: #{@tt_tt_list[@tt][4]}\nКомментатрий: #{@tt_tt_list[@tt][7]}", reply_markup: tt_markup)
      else
        p @tt
        tt_kb = []
        tt_kb << [Telegram::Bot::Types::InlineKeyboardButton.new(text: "##{@tt_tt_list[@tt][0]}", switch_inline_query_current_chat: "##{@tt_tt_list[@tt][0]}"),Telegram::Bot::Types::InlineKeyboardButton.new(text: ">>", callback_data: "next")]
        tt_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: tt_kb)
        bot.api.editMessageText(chat_id: message.from.id, message_id: message.message.message_id, parse_mode: 'HTML', text: "Инцидент #{@tt+1} из #{@tt_tt_list.size}\n Информация по инциденту <a href=\"h@ttps://172.21.231.235/@ttms/ticket?id=#{@tt_tt_list[@tt][0]}\">#{@tt_tt_list[@tt][0]}</a>: <a href=\"h@ttps://172.21.231.235/@ttms/@ttedit?id=#{@tt_tt_list[@tt][0]}&block_id=1,2,3\">Решить</a>\nТип: #{@tt_tt_list[@tt][1]}\nПодчинение: #{@tt_tt_list[@tt][2]}\nСтатус: #{@tt_tt_list[@tt][3]}\nЦелевой срок решения: #{@tt_tt_list[@tt][5]}\nПриоритет: #{@tt_tt_list[@tt][6]}\nОписание: #{@tt_tt_list[@tt][4]}\nКомментатрий: #{@tt_tt_list[@tt][7]}", reply_markup: tt_markup)
      end
    #rescue
    #  bot.api.send_message(chat_id: message.from.id, text: "Произошел сбой, попробуйте обновить список коммандой /report")
    #  bot.logger.error("### CallbackQuarryError: #{$!.inspect} ###")
    #end
  elsif message.data == "next"
    begin
      @tt = @tt + 1
      p @tt
      if @tt + 1 == @tt_tt_list.size
        @tt_next_kb = []
        @tt_next_kb << [Telegram::Bot::Types::InlineKeyboardButton.new(text: "<<", callback_data: "prev"),Telegram::Bot::Types::InlineKeyboardButton.new(text: "##{@tt_tt_list[@tt][0]}", switch_inline_query_current_chat: "##{@tt_tt_list[@tt][0]}")]
        @tt_next_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @tt_next_kb)
        bot.api.editMessageText(chat_id: message.from.id, message_id: message.message.message_id, parse_mode: 'HTML', text: "Инцидент #{@tt+1} из #{@tt_tt_list.size}\n Информация по инциденту <a href=\"h@ttps://172.21.231.235/@ttms/ticket?id=#{@tt_tt_list[@tt][0]}\">#{@tt_tt_list[@tt][0]}</a>: <a href=\"h@ttps://172.21.231.235/@ttms/@ttedit?id=#{@tt_tt_list[@tt][0]}&block_id=1,2,3\">Решить</a>\nТип: #{@tt_tt_list[@tt][1]}\nПодчинение: #{@tt_tt_list[@tt][2]}\nСтатус: #{@tt_tt_list[@tt][3]}\nЦелевой срок решения: #{@tt_tt_list[@tt][5]}\nПриоритет: #{@tt_tt_list[@tt][6]}\nОписание: #{@tt_tt_list[@tt][4]}\nКомментатрий: #{@tt_tt_list[@tt][7]}", reply_markup: @tt_next_markup)
      else
        @tt_next_kb = []
        @tt_next_kb << [Telegram::Bot::Types::InlineKeyboardButton.new(text: "<<", callback_data: "prev"),Telegram::Bot::Types::InlineKeyboardButton.new(text: "##{@tt_tt_list[@tt][0]}", switch_inline_query_current_chat: "##{@tt_tt_list[@tt][0]}"),Telegram::Bot::Types::InlineKeyboardButton.new(text: ">>", callback_data: "next")]
        @tt_next_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @tt_next_kb)
        bot.api.editMessageText(chat_id: message.from.id, message_id: message.message.message_id, parse_mode: 'HTML', text: "Инцидент #{@tt+1} из #{@tt_tt_list.size}\n Информация по инциденту <a href=\"h@ttps://172.21.231.235/@ttms/ticket?id=#{@tt_tt_list[@tt][0]}\">#{@tt_tt_list[@tt][0]}</a>: <a href=\"h@ttps://172.21.231.235/@ttms/@ttedit?id=#{@tt_tt_list[@tt][0]}&block_id=1,2,3\">Решить</a>\nТип: #{@tt_tt_list[@tt][1]}\nПодчинение: #{@tt_tt_list[@tt][2]}\nСтатус: #{@tt_tt_list[@tt][3]}\nЦелевой срок решения: #{@tt_tt_list[@tt][5]}\nПриоритет: #{@tt_tt_list[@tt][6]}\nОписание: #{@tt_tt_list[@tt][4]}\nКомментатрий: #{@tt_tt_list[@tt][7]}", reply_markup: @tt_next_markup)
      end
    rescue
      bot.api.send_message(chat_id: message.from.id, text: "Произошел сбой, попробуйте обновить список коммандой /report")
      bot.logger.error("### CallbackQuarryError: #{$!.inspect} ###")
    end
  elsif message.data == "prev"
    begin
      @tt = @tt - 1
      p @tt
      if @tt - 1 == 0
        @tt_prev_kb = []
        @tt_prev_kb << [Telegram::Bot::Types::InlineKeyboardButton.new(text: "##{@tt_tt_list[@tt][0]}", switch_inline_query_current_chat: "##{@tt_tt_list[@tt][0]}"),Telegram::Bot::Types::InlineKeyboardButton.new(text: ">>", callback_data: "next")]
        @tt_prev_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @tt_prev_kb)
        bot.api.editMessageText(chat_id: message.from.id, message_id: message.message.message_id, parse_mode: 'HTML', text: "Инцидент #{@tt+1} из #{@tt_tt_list.size}\n Информация по инциденту <a href=\"h@ttps://172.21.231.235/@ttms/ticket?id=#{@tt_tt_list[@tt][0]}\">#{@tt_tt_list[@tt][0]}</a>: <a href=\"h@ttps://172.21.231.235/@ttms/@ttedit?id=#{@tt_tt_list[@tt][0]}&block_id=1,2,3\">Решить</a>\nТип: #{@tt_tt_list[@tt][1]}\nПодчинение: #{@tt_tt_list[@tt][2]}\nСтатус: #{@tt_tt_list[@tt][3]}\nЦелевой срок решения: #{@tt_tt_list[@tt][5]}\nПриоритет: #{@tt_tt_list[@tt][6]}\nОписание: #{@tt_tt_list[@tt][4]}\nКомментатрий: #{@tt_tt_list[@tt][7]}", reply_markup: @tt_prev_markup)
      else
        @tt_prev_kb = []
        @tt_prev_kb << [Telegram::Bot::Types::InlineKeyboardButton.new(text: "<<", callback_data: "prev"),Telegram::Bot::Types::InlineKeyboardButton.new(text: "##{@tt_tt_list[@tt][0]}", switch_inline_query_current_chat: "##{@tt_tt_list[@tt][0]}"),Telegram::Bot::Types::InlineKeyboardButton.new(text: ">>", callback_data: "next")]
        @tt_prev_markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: @tt_prev_kb)
        bot.api.editMessageText(chat_id: message.from.id, message_id: message.message.message_id, parse_mode: 'HTML', text: "Инцидент #{@tt+1} из #{@tt_tt_list.size}\n Информация по инциденту <a href=\"h@ttps://172.21.231.235/@ttms/ticket?id=#{@tt_tt_list[@tt][0]}\">#{@tt_tt_list[@tt][0]}</a>: <a href=\"h@ttps://172.21.231.235/@ttms/@ttedit?id=#{@tt_tt_list[@tt][0]}&block_id=1,2,3\">Решить</a>\nТип: #{@tt_tt_list[@tt][1]}\nПодчинение: #{@tt_tt_list[@tt][2]}\nСтатус: #{@tt_tt_list[@tt][3]}\nЦелевой срок решения: #{@tt_tt_list[@tt][5]}\nПриоритет: #{@tt_tt_list[@tt][6]}\nОписание: #{@tt_tt_list[@tt][4]}\nКомментатрий: #{@tt_tt_list[@tt][7]}", reply_markup: @tt_prev_markup)
      end
    rescue
        bot.api.send_message(chat_id: message.from.id, text: "Произошел сбой, попробуйте обновить список коммандой /report")
        bot.logger.error("### CallbackQuarryError: #{$!.inspect} ###")
    end
  else
    begin
      number = message.data
      include GetParse
      cq_tt = get_parse_tt(URL,LOGIN,PASSWORD,number)
    rescue
      bot.api.send_message(chat_id: message.from.id, text: "Что-то пошло не так :( попробуйте снова либо сообщите разработчику, возможно он все починит ;)")
      bot.logger.error("### CallbackQuarryError: #{$!.inspect} ###")
    end
    if cq_tt==0
      bot.api.send_message(chat_id: message.from.id, parse_mode: 'HTML', text: "Инцидент не найден:\n-Введен неверный номер инцидента\n-Инцидент более не активен\nПопробуй обновить список инцидентов")
    else
      bot.api.send_message(chat_id: message.from.id, parse_mode: 'HTML', text: "Информация по инциденту <a href=\"h@ttps://172.21.231.235/@ttms/ticket?id=#{cq_tt[0]}\">#{cq_tt[0]}</a>: <a href=\"h@ttps://172.21.231.235/@ttms/@ttedit?id=#{cq_tt[0]}&block_id=1,2,3\">Решить</a>\nТип: #{cq_tt[1]}\nПодчинение: #{cq_tt[2]}\nСтатус: #{cq_tt[3]}\nЦелевой срок решения: #{cq_tt[5]}\nПриоритет: #{cq_tt[6]}\nОписание: #{cq_tt[4]}\nКомментатрий: #{cq_tt[7]}")
      kb = []
      kb << Telegram::Bot::Types::InlineKeyboardButton.new(text: "##{cq_tt[0]}", switch_inline_query_current_chat: "##{cq_tt[0]}")
      markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
      bot.api.send_message(chat_id: message.from.id, text: "Оставить комментарий к инциденту: #{cq_tt[0]}", reply_markup: markup)
    end
  end
end