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
    postback.reply({
      text: "Bonjour, je suis le bot de la Normandie Web School, je suis la pour vous renseigner toutes les informations dont vous avez besoin"
    })

    postback.reply({
      template_type: 'button',
      text: "Les messages seront lus par notre equipe humaine afin de pouvoir repondre a vos questions plus complexes",
      buttons: [
        { type: 'postback', title: 'Que sais tu faire ?', payload: 'GUIDE_PAYLOAD' }
      ]
    })
  elsif postback.payload == "GUIDE_PAYLOAD"
    postback.reply({
      template_type: 'button',
      text: "Que puis-je faire pour vous ?",
      buttons: [
        { type: 'postback', title: 'Prochaine JPO', payload: 'JPO_PAYLOAD' },
        { type: 'postback', title: 'Enzo', payload: 'ENZO_PAYLOAD' }
      ]
    })
  elsif postback.payload == "JPO_PAYLOAD"
    postback.reply({
      text: "La prochaine journee porte ouverte se deroulera le 9 fevrier"
    })
  elsif postback.payload == "ENZO_PAYLOAD"
    postback.reply({
      text: "Prendre Enzo en stage pourra etre benefique pour votre sante, voir conditions magasins participants"
    })
  end
end
