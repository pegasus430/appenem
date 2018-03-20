import React from 'react';

const detectLocale = (name, message) => {
  const original = document.head.appendChild.bind(document.head);

  const detector = (element) => {
    const pathExcerpt = '/client.crisp.chat/static/javascripts/locales/';
    if (element.tagName === 'SCRIPT' && element.src.indexOf(pathExcerpt) > -1) {
      const handler = window.$crisp.__spool.locale_handler.bind(window.$crisp.__spool);

      const changer = (hash) => {
        hash._strings.theme_text["4_chat"] = message;
        hash._strings.theme_welcome["1_chat"] = `Olá ${name}, tudo bom? ${message}`;
        return handler(hash);
      }

      window.$crisp.__spool.locale_handler = changer.bind(window.$crisp.__spool.locale_handler);
    }
    return original(element);
  }

  document.head.appendChild = detector.bind(document.head.appendChild);
};

const CrispLoader = ({ user, school }) => {
  return null;

  if (
    !window.CRISP_WEBSITE_ID &&
    ['coordenador', 'diretor', 'outro'].indexOf(user.role.toLowerCase()) > -1 &&
    user.origin_id == null &&
    school.dependency == 'private'
  ) {
    const name = user.name === '-' ? user.email : user.name;
    const message = 'Gostaria de te oferecer uma consultoria gratuita com base nos objetivos e resultados da sua escola. Você tem interesse?';
    detectLocale(name, message);

    window.$crisp=[];
    window.CRISP_WEBSITE_ID = '6e6de084-e720-469b-bc1f-a9935e92048f';
    const script = document.createElement('script');

    script.src = 'https://client.crisp.chat/l.js';
    script.async = 1;

    document.getElementsByTagName("head")[0]
            .appendChild(script);

    window.CRISP_READY_TRIGGER =  () => {
      let email = window.$crisp.get('user:email');

      if (email !== user.email && email !== null) {
        window.$crisp.push(["do", "session:reset", [true]])
      }

      window.$crisp.push(['set', 'user:name', [user.name]]);
      window.$crisp.push(['set', 'user:email', [user.email]]);
      window.$crisp.push(['set', 'user:phone', [user.phone]]);
      window.$crisp.push(['set', 'session:data', [[
        ['Escola', school.name],
        ['Cargo', user.role]
      ]]]);
    };
  };

  return null;
};

export default CrispLoader;
