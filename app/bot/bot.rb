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
      composer_input_disabled: false,
      call_to_actions: [
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
  when "Questions"
    postback.reply({
      text: "Posez moi une question :",
      quick_replies: [
        { content_type: 'text', title: 'L\'école', payload: 'JPO_PAYLOAD' },
        { content_type: 'text', title: 'Enzo', payload: 'ENZO_PAYLOAD' }
      ]
    })
  # =============== L'école ===============
  when "L'école"
    message.reply({
      text: "Les questions régulièrements posées à propos de l'école",
      quick_replies: [
        { content_type: 'text', title: 'diplome reconnu ?', payload: 'JPO_PAYLOAD' },
        { content_type: 'text', title: 'Transports', payload: 'ENZO_PAYLOAD' },
        { content_type: 'text', title: 'Le CROUS', payload: 'ENZO_PAYLOAD' },
        { content_type: 'text', title: 'La restauration', payload: 'ENZO_PAYLOAD' },
        { content_type: 'text', title: 'Des compétences ?', payload: 'ENZO_PAYLOAD' },
        { content_type: 'text', title: 'Les débouchés ?', payload: 'ENZO_PAYLOAD' }
      ]
    })
  when "diplome reconnu ?"
    message.reply({
      text: "Nous nous inscrivons dans le cadre de la Certification Professionnelle de la Commission Nationale de la Certification Professionnelle."
    })
    message.reply({
      text: "Titre RNCP de niveau II équivalent bac+3 \"Chef de projet digital\""
    })
    message.reply({
      text: "Organisme certificateur : Institut Européen F2i"
    })
    message.reply({
      text: "Titre enregistré au Répertoire National des Certifications Professionnelles au niveau II, par arrêté du 26/09/2016 publié au JO du 04/10/2016."
    })
  when "Transports"
    message.reply({
      text: "Le site de l’école est parfaitement desservi par les transports en commun. En effet, une station de métro est présente à quelques pas de l’école (station Jean jaures), et très bientôt la ligne T4 du TEOR."
    })
  when "Le CROUS"
    message.reply({
      text: " Les étudiants inscrits à la Normandie Web School ne sont pas éligibles à la bourse du CROUS."
    })
  when "La restauration"
    message.reply({
      text: "Plusieurs moyens de restauration sont à disposition des élèves :"
    })
    message.reply({
      text: "Un micro-ondes et un distributeur automatique sont présents au sein de l’école."
    })
    message.reply({
      text: "Un food-truck est présent tous les jours devant Seine Innopolis."
    })
    message.reply({
      text: "Plusieurs restaurants sont à proximité de l’école."
    })
    message.reply({
      text: "Un Supermarché existe proche du lieu de formation."
    })
  when "Des compétences ?"
    message.reply({
      text: "Non. Vous intégrez une école dans laquelle nous vous formons. A la Normandie Web School, nous intégrons des personnes avec une forte motivation !"
    })
  when "Les débouchés ?"
    message.reply({
      text: "Vous pouvez prétendre à plusieurs types de métiers du web :"
    })
    message.reply({
      text: "Développeur web, Développeur application mobile, Développeur Full Stack, Intégrateur, Chef de projet technique, …"
    })
    message.reply({
      text: "Ergonome, Web designer, Infographiste web et mobile, Créatif freelance, Chef de projet digital ou Scrum Master, …"
    })
    message.reply({
      text: "Responsable e-marketing, Responsable acquisition, e-commerce manager, Trafic manager, Community manager, Chargé de référencement, Chef de projet digital, …"
    })
  # =============== Troll ===============
  when "Enzo"
    message.reply({
      text: "Prendre Enzo en stage pourra etre benefique pour votre santée, voir conditions magasins participants"
    })
  end
  
  message.typing_off
end

Bot.on :postback do |postback|
  case postback.payload 
  when "GET_STARTED_PAYLOAD"
    postback.reply({
      text: "Bonjour, je suis le bot de la Normandie Web School, je suis là pour vous renseigner toutes les informations dont vous avez besoin"
    })
    postback.reply({
      text: "Posez moi une question :",
      quick_replies: [
        { content_type: 'text', title: 'L\'école', payload: 'JPO_PAYLOAD' },
        { content_type: 'text', title: 'Enzo', payload: 'ENZO_PAYLOAD' }
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
      text: "La prochaine journée porte ouverte se deroulera le 9 fevrier"
    })
  when "ENZO_PAYLOAD"
    postback.reply({
      text: "Prendre Enzo en stage pourra être benefique pour votre santée, voir conditions magasins participants"
    })
  end
end
