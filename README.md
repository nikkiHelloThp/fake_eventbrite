# README

## ajouter AWS

## ajouter une restriction de taille aux images uploadees
## ajouter un formulaire username

## Added gems
* in developpment group:
- faker
- better_errors
- binding_of_caller
- table_print
- letter_opener

### For production mailer:
3.3.2. La config en production
a) Choisir un service d'envoi
Ici, le cahier des charges est simple : on veut pouvoir envoyer des vrais e-mails. C'est tout.

Pour le faire, tu as le choix entre plein de services différents : Mandrill by MailChimp, Postmark, Amazon SES, etc. Nous, on a une préférence pour MailJet à THP (ils sont efficaces, pas chers et français 🇫🇷 🐓).

Toutefois, pour des raisons de fiabilité d’envoi depuis des adresses gratuites ou fake, je vais te montrer comment passer par le leader du secteur : SendGrid. Commence par créer un compte sur https://signup.sendgrid.com/ : indique un site web bidon, précise que tu es développeur et dis que tu vas utiliser leur SMTP/API. Ensuite va sur https://app.sendgrid.com/guide/integrate/langs/smtp et crée une clef API.

b) Sauver la clef d'API de façon sécurisée
Une fois cette clef en main, il faut la mettre en sécurité dans ton app Rails. Pour ça, rien de mieux que la gem dotenv appliquée à Rails ! Voici les étapes :

Crée un fichier .env à la racine de ton application.
Ouvre-le et écris dedans les informations suivantes : SENDGRID_LOGIN='apikey' et SENDGRID_PWD='ta_clef_API' en remplaçant bien sûr ta_clef_API par la clef que tu viens de générer. Elle est au format SG.sXPeH0BMT6qwwwQ23W_ag.wyhNkzoQhNuGIwMrtaizQGYAbKN6vea99wc8. N'oublie pas les guillemets !
Rajoute gem 'dotenv-rails' à ton Gemfile et fait le $ bundle install
Et l'étape cruciale qu'on oublie trop souvent : ouvre le fichier .gitignore à la racine de ton app Rails et écris .env dedans.
c) Paramétrer le SMTP avec les infos de SendGrid
Parfait : tu as une clef API de SendGrid et tu es prêt à l'utiliser. Il ne te reste qu'à entrer les configurations SMTP de SendGrid dans ton app. Va dans /config/environment.rb et rajoute les lignes suivantes :

ActionMailer::Base.smtp_settings = {
  :user_name => ENV['SENDGRID_LOGIN'],
  :password => ENV['SENDGRID_PWD'],
  :domain => 'monsite.fr',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}

d) Passer les clefs d'API à Heroku
Maintenant que tes clefs d'API sont bien au chaud dans ton .env, il faut trouver un moyen pour qu'Heroku les ait. Sans elles, ton app Rails déployée chez eux n'a aucune chance de pouvoir accéder au service SendGrid !

Tout est expliqué ici. En résumé, tu vas devoir passer des commandes du genre $ heroku config:set SENDGRID_PWD='SG.sXPeH0BMT6qwwwQ23W_ag.' (on te laisse lire la doc).

🚀 ALERTE BONNE ASTUCE
Comment savoir si tu as bien paramétré tes variables d'environnement (ex: ENV['SENDGRID_PWD']) via dotenv ? C'est simple : vas dans la console Heroku $ heroku run rails console et tapes tout simplement ENV['SENDGRID_PWD'].

Si le résultat est nil, c'est que tu as fait une erreur : la variable est mal définie.

Si le résultat est SG.sXPeH0BMT6qwwwQ23W_ag, c'est parfait : la clef est bien définie, elle est prête à être utilisée !

e) Tester l'envoi
Tout est prêt à présent ! Si ton site web est déployé en production sur Heroku, Heroku a les clefs pour parler à SendGrid : tu peux donc faire un test en créant un nouvel utilisateur.
Mais dans un premier temps, tu peux faire plus simple en testant une fois l'envoi directement depuis l'environnement de développement (ton ordi).

Enlève la ligne config.action_mailer.delivery_method = :letter_opener du fichier config/environments/development.rb ;
Va dans ta console Rails ;
Créé un utilisateur avec une adresse en @yopmail.com ;
Va vérifier que l’e-mail est bien arrivé sur http://www.yopmail.com/.
⚠️ ALERTE ERREUR COMMUNE
Ces services d'envois en masse ont été conçus pour envoyer des e-mails depuis des domaines propriétaires. Si tu ne possèdes pas un nom de domaine (genre "thehackingprojet.org"), tu vas devoir utiliser un destinataire soit fake ("no-reply@monsite.fr") soit gratuit (@yahoo ou @gmail). Dans les deux cas, tes e-mails vont être vite considérés comme du spam et tout simplement rejetés par la majorité des serveurs e-mails…

Seule solution pour tester ton code : viser des adresses du genre @yopmail.com qui sont habituées à servir de poubelle et du coup, elles acceptent tout !

SendGrid propose une super interface pour visualiser le statut des e-mails que tu as envoyé via ton appli et à travers leur SMTP : https://app.sendgrid.com/email_activity. En cliquant sur "Search", tu peux lister e-mail par e-mail l'état de leur envoi et de leur réception. Parfait pour voir si ton app communique bien avec eux, même si tes e-mails se font rejeter comme étant du spam (ça ne devrait pas arriver en écrivant à une adresse en @yopmail.com).

f) Et si je veux envoyer des e-mails qui ne soient pas considérés comme du spam ?
Comme je te l'ai expliqué, la solution propre, c'est d'acheter un nom de domaine et de le paramétrer dans SendGrid…

Une autre solution, qui n'est pas applicable pour une "vraie" société, est de ne pas passer par SendGrid mais directement par la configuration SMTP de ton adresse mail perso. Par exemple, pour envoyer des e-mails via ton adresse Gmail, il te faut remplacer la configuration SMTP de Sendgrid par les lignes suivantes dans /config/environment.rb

ActionMailer::Base.smtp_settings =   {
    :address            => 'smtp.gmail.com',
    :port               => 587,
    :domain             => 'gmail.com', #you can also use google.com
    :authentication     => :plain,
    :user_name          => ENV['GMAIL_LOGIN'],
    :password           => ENV['GMAIL_PWD']
  }
Évidemment, il faut que tu rajoutes dans ton fichier .env ton login Gmail et ton mot de passe sous la forme ENV['GMAIL_LOGIN'] = 'jose@gmail.com' et ENV['GMAIL_PWD'] = 'p1rouette_KKouette'.

####Gem devise
Registerable : possibilité de créer un compte via un formulaire. Aussi, possibilité d'éditer et de supprimer son compte ;
Recoverable : possibilité de réinitialiser le mot de passe et d'envoyer des instructions par e-mail ;
Rememberable : possibilité d'utiliser le fameux cookie remember me (la session reste ouverte) ;
Validatable : possibilité de donner des validations pour les e-mails et mots de passe (taille, regex, etc) ;
Omniauthable : possibilité de gestion de OmniAuth (un service pour se connecter via son compte Google, Facebook ou autre) ;
Confirmable : possibilité de forcer la confirmation par e-mail du compte ;
Trackable : possibilité de tracker le nombre de login, leurs timestamps, et les adresses IP ;
Timeoutable : possibilité d'expirer des sessions après un certain temps d'inactivité ;
Lockable : possibilité de verrouiller un compte après trop de tentatives échouées de connexions ;