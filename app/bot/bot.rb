require 'facebook/messenger'
include Facebook::Messenger

Facebook::Messenger::Profile.set({
  greeting: [
    {
      locale: 'default',
      text: 'Bonjour, trouvez toutes les informations dont vous avez besoin !'
    }
  ],
  get_started: {
    payload: 'GET_STARTED_PAYLOAD'
  }
}, access_token: ENV['ACCESS_TOKEN'])

Bot.on :message do |message|
  message.typing_on
  
  message.typing_off
end

Bot.on :postback do |postback|
  if postback.payload == "GET_STARTED_PAYLOAD"
    Bot.deliver({
      recipient: postback.recipient,
      message: {
        text: "Bonjour et bienvenue, je suis le bot de la Normandie Web School ! Je peux vous donnez toutes les informations dont vous avez besoin"
      },
      message_type: Facebook::Messenger::Bot::MessagingType::UPDATE
    }, access_token: ENV['ACCESS_TOKEN'])
    Bot.deliver({
      recipient: postback.recipient,
      message: {
        text: "Une personne de notre équipe humaine pourra lire vos messages, et ainsi vous répondre si vous avez une demande plus spécifique"
      },
      message_type: Facebook::Messenger::Bot::MessagingType::UPDATE
    }, access_token: ENV['ACCESS_TOKEN'])
  end
end