require_relative 'lib/GetModules/GetInlineQuary'
require_relative 'lib/GetModules/GetMessage'
require_relative 'lib/GetModules/GetCallbackQuary'
require_relative 'lib/Login'
require_relative 'lib/GetModules/GetCSV'
require 'telegram/bot'
require 'csv'

# version 0.9.5

LOGIN = ''
PASSWORD = ''
URL = 'https://172.21.231.235/ttms/listdata?filter_id=-1&cols=&filter_cols=&filter_vals=&do_search=false&nd=1516384575258&rows=50&page=1&sidx=&sord=asc'

token = ''
Telegram::Bot::Client.run(token, logger: Logger.new("lib/log.txt")) do |bot|
  bot.logger.info('Bot has been started')
  bot.listen do |message|
    include Login
    res = Login.login message, bot
    if res == 0
      begin
        raise "registration error"
        bot.logger.info("#{message.from.id} ### Register ERROR ###")
      rescue
        bot.api.send_message(chat_id: message.chat.id, text: "Вы НЕ зарегистрированы на сервере, свяжитесь с разработчиком")
      end
    else
      case message
        when Telegram::Bot::Types::InlineQuery
          get_inline_quary bot, message
        when Telegram::Bot::Types::CallbackQuery
          get_callback_quary bot, message
        when Telegram::Bot::Types::Message
          get_message bot, message
      end
    end
  end
end
