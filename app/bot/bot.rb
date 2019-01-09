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
    recipient = postback.recipient["id"].to_s

    Bot.deliver({
      recipient: {
        "id": recipient
      },
      "message": {
        "text": "Bienvenue"
      }
    }, ENV['ACCESS_TOKEN'])
  end
end
