require 'facebook/messenger'
include Facebook::Messenger

Bot.on :message do |message|
  message.typing_on
  
  message.typing_off
end