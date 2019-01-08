require 'facebook/messenger'
include Facebook::Messenger

Bot.on :message do |message|
  message.typing_on
  
  message.reply(text: 'Bonjour')
end