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
  },
  persistent_menu: [
    {
      locale: 'default',
      composer_input_disabled: true,
      call_to_actions: [
        {
          title: "Que sais-tu faire ?",
          type: 'postback',
          payload: 'GUIDE_PAYLOAD'
        },
        {
          type: 'web_url',
          title: "Le site internet",
          url: 'https://www.normandie-web-school.fr/',
          webview_height_ratio: 'full'
        }
      ]
    }
  ]
}, access_token: ENV['ACCESS_TOKEN'])

Bot.on :message do |message|
  message.typing_on

  case message.text
  when "Que sais tu faire ?"
    message.reply({
      text: "Que puis-je faire pour vous ?",
      quick_replies: [
        { content_type: 'text', title: 'Prochaine JPO', payload: 'JPO_PAYLOAD' },
        { content_type: 'text', title: 'Enzo', payload: 'ENZO_PAYLOAD' }
      ]
    })
  when "Prochaine JPO"
    message.reply({
      text: "La prochaine journee porte ouverte se deroulera le 9 fevrier"
    })
  when "Enzo"
    message.reply({
      text: "Prendre Enzo en stage pourra etre benefique pour votre sante, voir conditions magasins participants"
    })
  end
  
  message.typing_off
end

Bot.on :postback do |postback|
  case postback.payload 
  when "GET_STARTED_PAYLOAD"
    postback.reply({
      text: "Bonjour, je suis le bot de la Normandie Web School, je suis la pour vous renseigner toutes les informations dont vous avez besoin"
    })
    postback.reply({
      text: "Les messages seront lus par notre equipe humaine afin de pouvoir repondre a vos questions plus complexes",
      quick_replies: [
        { content_type: 'text', title: 'Que sais tu faire ?', payload: 'GUIDE_PAYLOAD' }
      ]
    })
  when "GUIDE_PAYLOAD"
    postback.reply({
      text: "Que puis-je faire pour vous ?",
      quick_replies: [
        { content_type: 'text', title: 'Prochaine JPO', payload: 'JPO_PAYLOAD' },
        { content_type: 'text', title: 'Enzo', payload: 'ENZO_PAYLOAD' }
      ]
    })
  when "JPO_PAYLOAD"
    postback.reply({
      text: "La prochaine journee porte ouverte se deroulera le 9 fevrier"
    })
  when "ENZO_PAYLOAD"
    postback.reply({
      text: "Prendre Enzo en stage pourra etre benefique pour votre sante, voir conditions magasins participants"
    })
  end
end
