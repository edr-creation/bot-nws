require 'facebook/messenger'
include Facebook::Messenger

Bot.on :message do |message|
  message.reply(text: 'Bonjour')
end