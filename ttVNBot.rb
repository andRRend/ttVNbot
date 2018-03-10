require_relative 'lib/GetJson'
require_relative 'lib/HashParse'
require 'telegram/bot'

LOGIN = ''
PASSWORD = ''
URL = 'https://172.21.231.235/ttms/listdata?filter_id=-1&cols=&filter_cols=&filter_vals=&do_search=false&nd=1516384575258&rows=50&page=1&sidx=&sord=asc'

token = ''
Telegram::Bot::Client.run(token, logger: Logger.new("lib/log.txt")) do |bot|
  bot.logger.info('Bot has been started')
  bot.listen do |message|
    case message
#-----###1(Inline Query)###--------------------------------------------------------------------------------------------#
      when Telegram::Bot::Types::InlineQuery
        begin
        include GetJson
        iq_json_file = GetJson.request(URL,LOGIN,PASSWORD)
        #json_file = File.open('lib/trash/test11tt.json', 'r'){ |file| file.read }
        iq_hash = JSON.parse(iq_json_file)
        include HashParse
        iq_tt_list = HashParse.get_list(iq_hash)
        if iq_tt_list==0
          bot.api.send_message(chat_id: message.from.id, text: 'Инцидентов нет')
        else
          i = 0
          @send_message = []
          iq_tt_list.each do |tt|
            @send_message << "<a href=\"https://172.21.231.235/ttms/ticket?id=#{tt[0]}\">#{tt[0]}</a>: <a href=\"https://172.21.231.235/ttms/ttedit?id=#{tt[0]}&block_id=1,2,3\">Решить</a>\nТип: #{tt[1]}\nСтатус: #{tt[3]}\nЦелевой срок решения: #{tt[5]}\nПриоритет: #{tt[6]}\nОписание: #{tt[4]}\nКомментарий: #{tt[7]}\n"
            i = i + 1
          end
          @send_message = @send_message * "\n"
          markup = [
              [1, "Список инцидентов", @send_message]
          ].map do |arr|
            Telegram::Bot::Types::InlineQueryResultArticle.new(
                id: arr[0],
                title: arr[1],
                input_message_content: Telegram::Bot::Types::InputTextMessageContent.new(parse_mode:'HTML', message_text: "Всего инцидентов #{i}:\n #{@send_message}")
            )
          end
          @send_message = nil
        end
        rescue
          bot.api.send_message(chat_id: message.from.id, text: "Что-то пошло не так :( Нет связи с сервером TTMS, либо неверный формат данных, попробуйте снова либо сообщите разработчику, возможно он все починит ;)")
        end
        bot.api.answer_inline_query(inline_query_id: message.id, results: markup)
#-----###2(Callback Query)###-------------------------------------------------------------------------------------------#
      when Telegram::Bot::Types::CallbackQuery
        begin
        number = message.data
        include GetJson
        cq_json_file = GetJson.request(URL,LOGIN,PASSWORD)
          #json_file = File.open('lib/trash/array4tt_m_d.json', 'r'){ |file| file.read }
        cq_hash = JSON.parse(cq_json_file)
          #hash = File.open('lib/trash/test11tt.json', 'r'){ |file| file.read }
        include HashParse
        cq_tt = HashParse.tt_by_number(cq_hash,number)
        if cq_tt==0
          bot.api.send_message(chat_id: message.from.id, parse_mode: 'HTML', text: "Инцидент не найден:\n-Введен неверный номер инцидента\n-Инцидент более не активен\nПопробуй обновить список инцидентов комманодой /report")
        else
          bot.api.send_message(chat_id: message.from.id, parse_mode: 'HTML', text: "Информация по инциденту <a href=\"https://172.21.231.235/ttms/ticket?id=#{cq_tt[0]}\">#{cq_tt[0]}</a>: <a href=\"https://172.21.231.235/ttms/ttedit?id=#{cq_tt[0]}&block_id=1,2,3\">Решить</a>\nТип: #{cq_tt[1]}\n#{cq_tt[2]}Статус: #{cq_tt[3]}\nЦелевой срок решения: #{cq_tt[5]}\nПриоритет: #{cq_tt[6]}\nОписание: #{cq_tt[4]}\nКомментатрий: #{cq_tt[7]}")
          bot.api.send_message(chat_id: message.from.id, text: "##{cq_tt[0]}")
        end
        rescue
          bot.api.send_message(chat_id: message.from.id, text: "Что-то пошло не так :( Нет связи с сервером TTMS, либо неверный формат данных, попробуйте снова либо сообщите разработчику, возможно он все починит ;)")
        end
      when Telegram::Bot::Types::Message
        begin
        if message.text=="/list"
          include GetJson
          json_file = GetJson.request(URL,LOGIN,PASSWORD)
          hash = JSON.parse(json_file)
          include HashParse
          tt_list = HashParse.get_list(hash)
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
          include GetJson
          rp_json_file = GetJson.request(URL,LOGIN,PASSWORD)
          rp_hash = JSON.parse(rp_json_file)
          include HashParse
          rp_tt_list = HashParse.get_list(rp_hash)
          if rp_tt_list==0
            bot.api.send_message(chat_id: message.chat.id, text: 'Инцидентов нет')
          else
            i = 0
            @rp_send_message = []
            rp_tt_list.each do |tt|
              @rp_send_message << "<a href=\"https://172.21.231.235/ttms/ticket?id=#{tt[0]}\">#{tt[0]}</a>: <a href=\"https://172.21.231.235/ttms/ttedit?id=#{tt[0]}&block_id=1,2,3\">Решить</a>\nТип: #{tt[1]}\nСтатус: #{tt[3]}\nЦелевой срок решения: #{tt[5]}\nПриоритет: #{tt[6]}\nОписание: #{tt[4]}\nКомментарий: #{tt[7]}\n"
              i = i + 1
            end
            @rp_send_message = @rp_send_message * "\n"
            bot.api.send_message(chat_id: message.chat.id, parse_mode: 'HTML', text: "Всего инцидентов #{i}:\n #{@rp_send_message}")
            @rp_send_message = nil
          end
        elsif message.text=='/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Привет, #{message.from.username}, я могу выводить отчет об инцидентах из системы TTMS, воспользуйся коммандой /help - список комманд для управления")
        elsif message.text=='/help'
          bot.api.send_message(chat_id: message.chat.id, text: "Список комманд для управления\n/list - вывод кнопок с номерами инцидентов активных на данный момент\n/report - подробный отчет об инцидентах активных на данный момент\n@ttVNbot-->Список инцидентов(из любого чата) - вывод подробного отчета\n/help - вывод этого сообщения")
        elsif message.text.include? "#"
          string = message.text
          tt_number = string[1,7]
          comment = string[9..-1]
          tthash = Hash["tt_number", tt_number, "user", message.from.username, "comment" , comment]
          File.open("lib/tt/#{tt_number}", 'w') {|file| file.write tthash.to_json}
          bot.api.send_message(chat_id: message.chat.id, text: "К инциденту: #{tt_number}, добавлен комментатрий: #{comment}")
        else
          bot.api.send_message(chat_id: message.chat.id, text: "Не знаю такой комманды! я понимаю комманды: /report, /list, /help")
        end
        rescue
          bot.api.send_message(chat_id: message.chat.id, text: "Что-то пошло не так :( Нет связи с сервером TTMS, либо неверный формат данных, попробуйте снова либо сообщите разработчику, возможно он все починит ;)")
        end
    end
  end
end
