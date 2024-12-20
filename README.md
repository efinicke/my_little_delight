# MyLittleDelight

Elixir, créé par José Valim en 2011, s'inspire profondément d'Erlang, un langage né dans les années 80 pour répondre aux besoins des télécommunications. Conçu pour gérer simultanément des millions de processus légers, Elixir repose sur la machine virtuelle BEAM, garantissant ainsi une robustesse inébranlable face aux pannes et permettant de maintenir des performances exceptionnelles même lorsqu'un processus échoue. Ce modèle parallèle unique rend possible des mises à jour en temps réel, sans perturber l’expérience utilisateur.

Avec une syntaxe moderne, proche de Ruby, Elixir est accessible tout en conservant tous les avantages d'Erlang. En exploitant pleinement les fonctionnalités et bibliothèques de son prédécesseur, il offre à la fois puissance et simplicité. Des applications comme Discord ou WhatsApp l’utilisent pour gérer des milliards d’interactions simultanées, illustrant à quel point Elixir est taillé pour les défis des systèmes distribués et massivement connectés.


## Skills

- **Elixir Fundamentals** : Exploration des bases du langage Elixir, de sa syntaxe fonctionnelle, des structures de données immuables (maps, lists, tuples).
- **API Integration** : Interaction avec l'API Web de Spotify, gestion de l'authentification via OAuth et exécution de requêtes HTTP à l'aide de `HTTPoison`.
- **JSON Parsing** : Traitement et analyse des réponses de l'API en utilisant la bibliothèque `Jason`.
- **Data Filtering and Sorting** : Implémentation de la logique pour filtrer les singles et trier les albums par date de sortie.
- **Secure Configuration & Caching** : Utilisation de `dotenv` pour sécuriser les clés API et gestion des tokens via Cachex pour limiter les appels API et préserver la sécurité des données.


## Project Overview

 Ce petit projet qui me permet de m'initier au langage Elixir, consiste à interagir avec l'API Web de Spotify pour récupérer, filtrer et trier les albums de l'artiste Orelsan, par le biais de 3 fonctions qui permettent de :
- **Lister tous les albums d'Orelsan** : Récupérer la liste complète des albums de l'artiste à partir de l'API Spotify.
- **Filtrer les singles** : Exclure les albums considérés comme des singles pour ne conserver que les albums complets.
- **Trier les albums par date de sortie** : Organiser les albums par ordre chronologique, du plus récent au plus ancien.

Il sert d'exemple de la manière dont on peut interagir avec une API externe, traiter des données JSON et gérer des requêtes HTTP en Elixir.


## Architecture

### Structure du projet

```bash
my_little_delight/
├── lib/
│   ├── my_little_delight/
│   │   ├── cache.ex            # Gestion du cache pour les tokens
│   │   ├── spotify_api.ex      # Module principal pour interagir avec l'API Spotify
│   │   └── spotify_auth.ex     # Authentification via OAuth pour générer le token
│   └── my_little_delight.ex    # Module principal de démarrage de l'application. 
├── test/
│   ├── spotify_api_test.exs    # Tests automatisés pour vérifier les fonctionnalités de l'API Spotify
│   └── test_helper.exs         # Fichier de configuration pour les tests
├── .env                        # Variables d'environnement (sécurisées avec dotenv)
├── mix.exs                     # Fichier de configuration du projet (gestion des dépendances notamment)
└── README.md                   # Documentation du projet
```


### Lib Content

- **my_little_delight.ex :** Module central de démarrage de l'application Elixir. Il contient la logique nécessaire pour initialiser les différents services et processus de l'application, ici le démarrage du cache automatique à l'éxécution du programme pour gérer les tokens d'authentification.
- - **Module spotify_auth.ex :** Ce module est chargé de l'authentification via OAuth avec l'API Spotify. Il s'occupe de générer un token d'accès et de le stocker pour l'utiliser dans les requêtes suivantes.
- **cache.ex :** Ce module gère le cache des tokens. Au lieu de générer un nouveau token à chaque requête, il conserve un token valide et le régénère uniquement lorsqu'il est expiré, ce qui évite des appels API inutiles.
- **spotify_api.ex :** Ce module contient les fonctions principales pour interagir avec l'API Spotify. Il est responsable de la récupération des albums d'Orelsan, du filtrage des singles et du tri des albums par date de sortie.


## Usage 

Pour exécuter et tester l'application :

1. Cloner le repo en local : 
   ```bash
     git clone https://github.com/efinicke/my_little_delight.git
     cd my_little_delight
   ```

2. Installer les dépendances :
  ```bash
    mix deps.get
  ```

3. Créez un fichier `.env` à la racine du projet pour stocker vos clés API Spotify :

  SPOTIFY_CLIENT_ID=1af9cc52b52c47deb8b6b061770262ca
  SPOTIFY_CLIENT_SECRET=0bbda58598d04cddbdab5a256fe18038
  SPOTIFY_REDIRECT_URI=http://localhost

  
4. Compiler le projet :
  ```bash
    mix compile
  ```

5. Tester l'application avec les tests automatisés inclus (appel des trois fonctions) :
  ```bash
    mix test
  ```
Possibilité de décommenter les `Enum.each` dans le fichier `spotify_API.ex` pour obtenir plus de détails pendant l'exécution.


6. Pour tester les fonctionnalités en mode interractif (iex), lancer la commande suivante pour démarrer une session interactive avec l'application en cours d'exécution :
  ```bash
    iex -S mix
  ```
Exemples de tests dans le terminal interactif : 

- **Lister les albums d'un artiste :** MyLittleDelight.SpotifyAPI.list_albums()
- **Lister les albums d'un artiste sans les singles :** MyLittleDelight.SpotifyAPI.list_albums_without_singles()
- **Lister les albums d'un artiste triés par date :** MyLittleDelight.SpotifyAPI.list_albums_sorted_by_date()

- **Vérifier la validité du token :** MyLittleDelight.SpotifyAuth.get_token_expiry()
- **Récupérer un token d'acccès :** MyLittleDelight.SpotifyAuth.get_access_token()
- **Vérifier l'expiration du token :** MyLittleDelight.SpotifyAuth.get_token_expiry()

- **initialiser le cache :** MyLittleDelight.Cache.start_link(cache_name: :spotify_cache)
- **Vérifier le cache :** Cachex.get(:spotify_cache, :access_token)
- **Effacer le cache :** Cachex.clear(:spotify_cache)

  S10E08 José Valim on the Future of the Elixir Ecosystem
===

Intro/Outro: ​

Welcome to another episode of Elixir Wizards, a podcast brought to you by Smart Logic, a custom web and mobile development shop. This is season two where we are looking to the next. 10 years of Elixir. We'll be talking with our guests about what the first 10 years might tell us about the future of Elixir.

Owen: Hey Hey everyone. I'm Owen Bickford, senior developer at SmartLogic.

Sundi: And I'm Sundi Myint, Engineering Manager at SmartLogic.

Owen: and we are your host for today's episode. we're joined by José Valim, Chief Adoption Officer at DashBit, in this episode, we're discussing the next 10 years of the Elixir Ecosystem.

Sundi: Welcome, Jose. Thank you for being here today. We obviously are very excited to, to get a chance to talk to you, especially on this subject. The last 10 years of Elixir has been amazing for all of us who've gotten a chance to work with Elixir and we're looking forward to the next 10 years. One thing that we wanted to kick off this episode by talking to you about is, do you remember the first time you reacted to a pull request with a Rainbow Hearts emoji lineup?

José: I believe I was not the one who started, or maybe I was, but I wasn't at the same time. So, at Plataformatec, my previous company we had. A close group of contributors, which were, me, Carlos Antonio, and Rafael França.

And at some point, all three of us, we were Rails core team members, and we maintained like, uh, important opensource projects for that community. And then at, it was very common. And then I believe it was Carlos, or maybe Rafael, who kind of started it. But we picked up very quickly. And it was common that, you know, people would open up issues and I would say, Hey, you know, don't use the issue tracker for questions.

Like, we have this mailing list thing, or, asking more information. So I would always use, some like common replies and then someone, uh, if I remember correctly, his name, was Vasiliy. It was, uh, nashby_ on GitHub. He created a Firefox extension for me, or Chrome extension, which added candid replies to GitHub way before GitHub had canned reply.

So it added a bunch of buttons like below the common thing with the replies I would usually use. And one of them was the heart combo, and that just made it easier and all of us use this extension and I think that's when, uh, it created a life of its own. And then, I assume that they are still using it until today and that's the history behind it.

Sundi: There's a little bit of a fan following behind that. Everyone really looks. Forward to getting those rainbow hearts. So, it's one of those nice things about the Elixir community that people mentioned.

Owen: Yeah, there should be some Elixir merch with the hearts, you know, and the Elixir logo.

José: Yeah. Could be. Yeah. I realized at some point, that was a thing. That people were like, oh, like they would say, oh, I got the hearts from José or something like that. And it was funny because I think in one pull request someone commented that I did not drop any hearts, and it made me feel really bad.

It was just like, you know, sometimes you just, just forget about it. Right? Or, or you're doing something, you get distracted. But then I rectified that, but yeah.

Owen: Cool. So, we just watched the ElixirConf EU talk, so we're excited to kind of jump into that, but I think before we get all the way into the weeds, for anyone who's. Who's not heard, of course we're Elixir Wizards, everyone here's heard of Elixir and José, but maybe a personal introduction. Anything you wanna tell us about kinda your background, where you're from and what you've been up to?

José: Cool. Yeah, I am, José Valim, creator of Elixir. I am Brazilian, but I have been living in Poland for the last 13. Yeah, it has been 13, yeah, 13 years of my life. And most of the time I'm working on the Elixir ecosystem. A bunch of different projects. Most of my time is actually spent on the ecosystem itself rather than Elixir

and I work at DashBit, where we do our best to continue to help companies adopt Elixir and continue investing in the community.

Owen: So have you, as someone who went from a very a warm climate to a very cold climate for about 10 years, 11 years, have you acclimated, are you used to it or do you kinda like cringe every time it starts to snow again?

José: Yeah. I say at this point that I should, because 13 years, like I either get used to it or I stop complaining. yeah, but I, I feel like I've acclimated because like last week it, we got like 15 degrees Celsius. And, and then I was like outside only with his t-shirt, which pretty much means that, you know, like in Brazil, if it's, if it's 15, you're, you're getting like two layers, you know, of blouses or something, which pretty much means that I think I've, I got used to it, so, yeah.

Sundi: When, when we're talking a little bit about the Elixir ecosystem, I'm thinking about the way that I plan projects. Whether it's like, how do I want my backyard to look? Or what is this roadmap of our next Elixir project gonna look like? I think about all the struggles that I have with planning things out, and I wonder what does it actually mean for you When you say you plan out the elixir ecosystem, do you know what next projects you want?

Do you have an idea in your head about, you know, next 10 years of Elixir? Like where do you want Elixir to completely encompass these different facets of different technologies? How does that look like, the planning process for you? 

José: I think there are a couple things that take part in answering that. So one is that I've, I've always seen Elixir development of the community to be like decentralized. The language was designed to be extensible. So if somebody wants to take it, like to, to do machine learning stuff or embedded, they should be able to build off that revolt requiring, changing the language itself. So like that's what is very exciting. So, 12, 10 years ago, Ecto was the example of that. How we can send queries to the database and we would have this expressive language that compiles to SQL and it's all Elixir it didn't require change, elixir itself, but the most recent example is (Nx) Numerical Elixir.

Why? You can actually compile Elixir to the GPU, and we are doing those things without changing the language. So I think that that was my responsibility, uh, 10 years ago when design the language was to think about the, the abstractions that would allow the language to be extensible and allow this decentralized development.

And I think, I made a good job, let's say, to make that a possibility. And, and I think it was the right call because, projects like Nerves for example, or Membrane, I, I don't have, uh, for audio video streaming and Nerves for embedded, I don't have any involvement in those projects.

Right. And they're able to create their own communities. And thrive on that. So yeah, that was the direction, so the planning on my side is , I think it, I've, I've. Done. I've planned like 10 decades ago, so I don't have to plan now. And now what I can do is that I can work on the things that excite me.

And that's what I, I tell everybody like, my keynote at last year's Elixir Conference, Europe was exactly my future with Elixir because I wanted to share the things that I'm excited about, and I know, what I'm excited about is going to have a large impact in the community. I, I understand that, but it's more like, if you are excited about your own things, you can also do that and build that things, because the things I'm excited about, most of them, I am developing them without changing the language.

So anybody can do that, too. So I think, like, assuming that, My job was well done in making Elixir extensible, then I think my other job, the job after that is in supporting the community, right? If I can come up with new ideas or participate in new projects like I'm doing with Nx (Numerical Elixir), then that's great and I'm excited about those projects, but it's not a requirement.

So, it's really up to the community itself.

Sundi: a great aspect of working with Elixir, over the last 10 years. One of the biggest selling points is that it just runs. It doesn't really break in the way that some other languages will. I'm using break. The air quotes are on the word break, very lightly. What would you say to somebody who is skeptical that it will be similar to that in the next 10 years? 

José: so based on like Elixir being extensible, I think one of the things that has allowed us to be unbreakable is that if we want to change something, the language we are not comfortable with, we can change the language because it's accessible, most of the language is written in Elixir itself, so it's very rare that we can paint ourselves into a corner where we're like, well, you know, the only possible answer for this is to break existing code. Throughout our history, there is only one issue in the issue tracker for Elixir 2.0, whenever that happens, which is a very silly thing that it's, it's going to affect like very, very few people, which I think it's a, and well, lemme say what it is.

So, we have module attributes in the links, right? You can say add something and you can put a value in there. And at Doc is a module attribute where we put a documentation and because in Elixir everything's an expression, it means that at Doc has to return something, right? And what it returns is, I don't remember exactly what it returns, but whatever it returns, Is not enough to access information about documentation.

So, uh, the proposal is to change the value of that attribute to something else. So it's like, it's a very small change, like how many people rely on the value of at doc? And that's the only one. So, I think it's a pretty good track record and whenever, but we have a lot of deprecations, right?

Like if you go to, to our change log where released all the deprecations that we have done throughout the years. It's a long list, but that's exactly the idea. It's like, you know, if something we feel like, oh, this was a mistake, we can deprecate it, we can, uh, improve, can, we can provide new APIs and we can do all of that without breaking existing code.



Owen: So sometimes, speaking of Deprecations, you might work on an older version of Elixir for a while. Sometimes, you know, upgrades are kind of prioritize lower than feature development. So you might find yourself kind of dealing with a large batch of deprecation warnings. I'm curious if you have kind of suggestions for folks as they're kind of working through those so that they're not, kicking the can down the road for another year sometimes. Do you recommend like working on deprecations in isolation like a dedicated PR or something like that?

José: Yeah, that's usually the process that I go through. I update and, and then I, I, I go for the warnings. And most of the time the warnings, they are very small fixes. Right? So I think the next version has probably just one and two warnings, and like the warning is very small. We have the log levels and then Erlang added like five years ago, they added like Syslog support and Syslog is like, &quot;emergency critical error notice&quot; so all those they announced and we had logger warn, which was a verb. So this is a theme that, you know, we have an alternative for that for a while. And you just have to change from logger warning to warrant to warning.

So it's a, like those, there are typically small changes that you can go and do it with no problems. And usually I I reserve a PR for that separate pr or sometimes when it's super small, just do it all together and in the same path, which is, has been typically the case with Elixir.

Owen: So that logger dot warn, that's like my default. So I've been trying to like, train myself to say warning. With Dialyxir and language server, I get the squigglies, the compiler warnings that, like I've, I've used a deprecated function. So, that's, that's always helpful to see it in real time. As I'm updating my kind of mental process, you know, writing the code, But I think, our listeners might kill us if we talked about Deprecations for an hour. So going back to Elixir Conf and, uh, elixir Conf eu, and the things you were talking about just a few days ago, Looks like your focus has been largely on LiveBook and Elixir tooling. Is that fair to say?

José: Yeah, I think so. And machine learning. Yeah.

Owen: And you mentioned it right at the top of the, of the talk that was the biggest EU conf or Elixir EU conf ever. Do you know, have any idea how many people were there?

José: I believe it was between 550, 600.

Owen: That is, that's a large conference.

Sundi: Yeah, I, I just sat there with a shock face. No one could see it, but shock face. 

and. 

José: Yeah. And, and. there were, also online attendees, in addition to that, right? Mm-hmm. I think like 200 online or 250.

Sundi: Wow. What Owen was talking about just now, about the squiggly lines and error warnings and stuff. Reminded me of something that you said at your ElixirConf EU talk. About kind of this focus and getting feedback from the IDs. Can you expand on that idea a little bit more?

José: Yeah. So, what has happened, as you were talking about, a lot of the things in the community are done by the community. So, we have the community working on Elixir language server (ElixirLS) and tools that are related to that. it was very funny because at some point, Marlus Saraiva, who worked on IntelliSense, which was used by the Elixir Language server, he worked at Dashbit.

So he implemented some of those ideas. And IEx also has a little bit of smartness. Not as much as an editor, but you, you know, you can hit tab, you can get completion. So there's some smartness in there. And I was the one who, who worked on those things and then Jonathan at Dashbit, he started working on Livebook.

And Live book is going to have like the same features. So we're at a point where, three people in the same company, and it's like, this is a small company's, a company like six people. They have all implemented the same feature in different places. one of the things was that, well, you know, enough, right?? It probably makes sense for Elixir to, to provide some functionality around this. And the other one is that Marlus would say like, in order to provide some of the features, he needed to use private APIs and because it's private, like he knew it was private. Right? It could break between Elixir versions, which means like, there is a new Elixir version, but the language server would be broken. That version and just like, It slows everything down. So it made sense to like start to, to expose some of the APIs necessary for those projects. And the thing, and I touched on this, during the talk is that, the Elixir compiler, right?

It only works with like correct code. Like if you write a topo and you forget to close the topo, it's invalid syntax, right? You forget to, you forgot to close the topo. You have to fix, and then the compiler is going to compile. But an idea, it, it's not that like, you know, if you forget to close the topple somewhere, like even the syntax is invalid.

You want completion to still work, to still happen. So, that's one of the challenges. So we started, solving some of those problems in itself and try to provide a more stable foundation that whoever is working on those tools, it's going to be more robust. And when there is a new Elixir version, nothing is going to break because they are relying on, on those shared abstractions Now.

Sundi: I was very interested when you started talking about that because, earlier this year I worked in Flutter as well as Elixir I've been bouncing between Flutter projects and el Elixir projects, and when I work in Flutter, VS code is incredibly, I I like to say it, likes to yell at me a lot. it doesn't let me run my code.

If anything is just out of place. Anything is formatted wrong, which is like a little bit in the other direction. But then when I started working back on my elixir code, I felt like. Oh vs code. You're so quiet, why aren't you talking to me anymore? You know, it's just the lack of types, or type sensitivity there.

But do you envision a world in which the IDs can be a little bit more verbose in that way? I think that's what you were kind of getting at. 

José: Yeah, it's in a way, like I am still a bit removed from that, so I'm working on the foundations that others build on top. So yeah, my goal is that we're continue improving this foundation and that's going to improve the ID experiences. but I am still like a bit far removed from there to, to say for sure that this is going to happen or this is not going to happen.

The other thing is that, yeah, types, they are a, you know, you're going to get a lot more screaming at you. Let's say that, when you have types and, and that's actually like this, I think this feeling where like, Hey, you know, like this thing is yelling at me all the time and it's annoying, but then when it stops yelling, you're like, Hey, can, maybe you could, yeah, a little bit more.

I think this is something that people are actively researching on like, there are people working on, because a type language, they, they have, if it's like fully statically typed, like they need the types to match, otherwise they just cannot compile. So there is research going on in like, Hey, maybe I can compile the code.

But when it gets to this point, It's going to to fail at runtime. Like I'm going to say, Hey, there's a type error thing. Because there are a lot of things, like even if you get a type error, it may still be valuable to compile that software for you to well, maybe I can understand the type, but, maybe I still want to debug that in order to understand why that type is happening, right? Or maybe to run a task, of course it's still going to fail, but being able to interact with the system after compilation, even with a compilation error, still valuable. So that's a, a research that is happening, on like statically compiled languages.

And with Elixir, we are approaching from the other side where we are dynamic and people want more, let's say, yelling. Maybe they want more types and how the types can help them, get the feedback early on. So it's very interesting, want to find a middle ground somewhere and there research on both sides to make that happen. 

Sundi: That's exactly what happened to me going from Elixir into Flutter. For the first time in a while where I really just wanted, I knew the data was wrong, I knew it wasn't gonna give me exactly what I needed, but I, I wanted to interact with it to see how I could get it to the place where it was something I needed.

And I'm a visual person, so looking at it without the code running was pretty difficult for me. then we got there eventually, you know, once I, I got into that, that type mentality and, it's an interesting kind of, problem set to have to go back and forth between those and have your brain shift like that a little bit.

Owen: Right. And speaking of types, listeners stay tuned. The season is about the future of Elixir and we have an episode coming up. Just a few weeks that we'll be diving into more depth on types and the future of types in Elixir. Including today's guest, Jose. So, yeah, can't wait to get more into the weeds on that. Thinking about, type like sub typing su suggestions, like while you're typing your keys in your keyboard. 

I've noticed some improvements over the past few weeks with Elixir Language server. so I think this is new. When I was typing in a struct. Like, I had a struct in one module and then I was typing, opened up the struct in another module and I started to see the keys like as a suggestion in the dropdown, in the VS code UI. So I think that's new and I think that's, that's super helpful. That gets us a little bit closer, even without static types to, uh, To things like, uh, flutter, flutter tooling. And speaking of tooling, I think with Live Book and the, the talk you gave at ElixirConf EU there's so many different features that are, that are being added to Livebook for monitoring a, a running application, for course documentations the thing we all think of with live book, but. What are, maybe, what are some of the most exciting features that you, you've been either seeing or or working on there with Livebook? 

José: honestly, it's, it's, it's hard for me to, to pinpoint a future because it has been so, as I say in my talk, right? The talk was called Bringing Elixir to Life, and the idea was that historically when I think about Elixir and how people are going to interact with it, they're going, you know, or they're going to use the terminal, right?

Or at best an id, which we can do a lot, but it's still, still like a limited medium because an ide, it's a lot more let's say, Well, you are interacting with it all the time, but it's kind of limited. It's not like you can go to, you can easily go to the IDE, write some Elixir code, and teach your own idea to do like cooler stuff.

Right? You know, I, I imagine that the process of writing ID extensions, well most likely you're not going to be using Elixir first of all. But there is probably some process behind that which makes sense for them. But if you're an Elixir developer and you just want to explore ideas, there is this work that needs to happen. But with Livebook, that friction is pretty, pretty low. Very quickly you can write some Elixir, maybe some like sprinkles of JavaScript. And then you can start like building interactive and collaborative things, which can either be like an interactive or collaborative application that you are building for a work, but it can totally be interacting with your Elixir runtime. Right? Or interacting, uh, visually with a problem that they're trying to solve. So, it's very hard to pinpoint because like the whole thing, like just thinking now about this problem in this way, like, I'm writing Elixir and I'm adding this feature to the language and wait, how that's going to. Could we leverage these in Livebook somehow?

It's, it's just very exciting and opening our minds to a bunch of different things and I keep thinking about, for example, In Elixir, I think we can kind of look at our software and separate it into three main concepts. So once the data, topos, strings, lists, maps, the other are the modules, which is the code where we put our code with the functions.

And then the other one, those are the other processes. And writing Elixir code is basically interface with those things well. Right. Like, well, which, which code is this process running? And then if you create any data structure is going to belong to a process. So those are the three main things.

And one of the things that I haven't solved yet, is, you know, how can we make. The distinction between those three things clearer in Livebook. So that's a, that's an open question that I have not answered. I think there's like a lot of quick stuff that we can do. I absolutely love smart sales as well.

I. And with like, with three clicks, you can have a machine learning model running. Two weeks ago we had the Livebook launch week, and one of the things that we did in this launch week, it's like how I can build a machine learning chat application where you can send it audios and then it's going to send us a message to the chat.

We do everything we deploy in 15 minutes. I think all those things they are. very exciting there and, there are so many more ideas of things that we can do and build. Yeah, I'll, I'll, I'll stop here before I continue rambling. 

Sundi: Yeah, launch week looked really fun. I was gonna ask you what you were most excited to announce, but it kind of sounds like you either don't have a favorite or it might be the Smart cells your favorite.

Owen: Yeah. What's your favorite child? It's like, that's what we'll keep asking.

José: Yeah. And it's so funny because like doing a launch week, it's probably obvious in hindsight, but it's like, it's very tiring. And I, I go through those things where we were like, so before we, we did not have a launch week, but we have like, I think we went announced Bumblebee, which is like the portrayed machine learning models that you can run in Livebook.

Because that touched so many projects. Like it touched Nx, there was Bumblebee, there was Livebook. Releasing that thing was like exhausting. And then I'm like, all right, I'm never doing this again. And then like three months, four months later, we were like, Hey, what if we do a launch week?

Right? Where you have like to coordinate all those things, record five different videos, um, you know, and then, and then it's over. Then it's like, Well, maybe it's the first and the last launch week ever, and then I'm sure that, you know, like in four months again, I'll be very excited about something and it's either another launch week or another big release, so...

Sundi: I'm excited for the launch week. That's gonna happen before ElixirConf US now, cuz that's four months from now.

José: Yeah, that's true.

Owen: Yeah. There was a lot of exciting stuff happening in, in Livebook, the mermaid charts. I've been kind of brushing up on Mermaid we actually, we just this past week, Sundi and I, and some of the, some of our team were, building a Livebook to kind of think through some complex data structures, kind of building up mock ecto schema and that kind of thing. That was extremely helpful for that. 

Sundi: It was actually, it was so good because when we're in planning phases of a new project, it's like too much to go in and make a new repo for like the full project. It's like almost overwhelming to think about when you have a larger organization to think of, or not organization, but like the way you organize your code, especially when it's going to be a larger code base, it is so helpful to be able to run real Elixir code, but not have it like reference modules that don't exist yet and have placeholders for those things or run, you know, fake schema and things like that.

And we just, we've been using live book for that in the last, just even the last three days. And it's been a game changer for us, just especially, like I said, I'm a visual person, so that was super helpful and I'm so excited for that drag and drop stuff that you were demoing at ElixirConf EU.

Owen: Drag and drops. Yeah, that's what I was getting to, is like that feature in particular like stuck out to me as like, oh, you can just change your data pipeline by dragging and dropping some things in Livebook and kind of see how the results changed. That was really cool.

José: Yeah. And, and it's funny because, uh, I think the DBG feature is like a perfect example of the chicken and the egg issue. If you ask like who came first, Livebook or DBG or something like that. And the reason why DBG exists, like the first proposal for dbg, I think.

like two years ago before it was implemented. because the original proposal was, because if you use DBG outside of live book, it's like a nice inspect where it inspects the expression and shows a couple things and, and then I was like, this is cool and I can see how this is handy, but it doesn't feel like it is enough to justify the addition to the language. And then when I started working a Livebook, I saw there was, there is a paper called Unravel. I'm not going to remember the whole title of the paper, but it was like if you're working on, imagine that you, in Python we have this thing called data frames, which is basically a table and then you can do operations on this table.

You can, filter order this kind of thing. So you may have like several operations in a row as if it was an Elixir pipeline. And this unravel paper was like, well, we wanted to see each step of this pipeline when we are debugging code, right? So, um, So, and then the, the paper introduces this, this widget, because it's running on a Jupyter Notebook, which is for the Python community, and then they do it for the AR community as well.

So they introduce this idea with a pipeline, and then I'm looking at that, and then the wires start to cross. So I'm like, wait, We were thinking about dbg, but this feature where, because if you go to, to your electric call today, if you have a pipeline, if you put DBG as the last step of the pipeline is going to print the intermediate value of which thing on the pipeline, right?

So, so I was like, wait, we can actually bring this feature. To true Elixir dbg. And what we can also make is that if we add this to Elixir dbg, we can make it so the backend is pluggable. So when you're running DBG Inside Livebook, you get a visual representation of the pipeline where you can modify, move things around.

So, so it was really funny because it was exactly, I, I. I mean like going back to the talk, Bringing Elixir to Life, that was exactly it. Now you are getting ideas that come from a visual medium, and I can bring them back to the way that we usually work, which is like, Hey, I want to debug something. One of the things that I may wanna do is to use like print based debugging, right?

And now we can enrich that experience, even if it's in a poor medium, right? But we can also provide features for the rich medium too.

Owen: Was the clickable supervisor or supervision tree, is that new as well? Cause I know I'd been able to render a supervision tree in live book for a while, but the clickable feature, is that new or is that something I just completely missed? 

José: I think that's, I think that's like three or four months old. So relatively new. As long as you have keynote, we are going to automatically detect the supervisor, for example.

Owen: That's cool. So you've talked about, there's kind of a roller coaster, right, of like excitement and kind of like recovery over time, I think for you especially. But I think for any of us as engineers, we go through phases of, you know, having more or less energy and recovering and ramping up for the next, the next thing.

So I'm kind of curious at a higher level, like what keeps you motivated to come back and keep building on new features and growing the ecosystem here for Elixir?

José: I think for me a lot of it it's just personal motivation, like finding the issues, or the problems exciting to work on, or hard problems to solve. I like working in Livebook because for me it's, as you were saying, it's like thinking about how Elixir works in Livebook.

It's a completely new area for me, I feel like being, I like being challenged in that way and try to think about those things and, and read and research and find. What other people are doing. So generally that's, that's the thing. , that's why I say like, for example, I love doing like performance work, for example.

I always find it very fun because for me it's a challenge, right? You have a code, somebody says, Hey, this is low, right? And then it's like, yes, challenge accepted. I'll try to make it faster. A lot of it is, is just like, you know, uh, personal challenges for me, it's, it's the, a lot of the motivations in there.

Owen: And do you ever sleep or do you work 24 hours a day?

José: I, I, I do my best to sleep the recommended amount of hours, which I believe at my age is about eight hours. So, you know, staying between seven, eight. yeah. 

Sundi: when we interviewed Janiton last year, we normally record at, about 4:00 PM Eastern and we try to be flexible when we're recording people who are in Europe or Hawaii or wherever. And Janin says, no, that's fine. And then we got on the call and halfway through it was like, isn't it like 3:00 AM where you are? Jonathan Klasko for those who don't know who we're referencing, but I just, that and the Rubik's Cube thing that he can do super fast were like the things that I thought of so quickly with him. It was great. Between that and, and this conversation, I mean, we're talking about Livebook more than I think I ever have in my last year or two of experience.

Is there a way that you hope the community uses Livebook now that you've invested all this time and these features into it. How do you see the community using Live book in the next 10 years? 

José: Honestly, I don't know. So when I think about it, for me, I think a lot about like the learning experience. I hope it's going to, to be, A way to welcome your developers into the language and, and the ecosystem because of everything that we do there. Like, you know, having the desktop installer, so you know, you don't have to go, you don't have to figure out all these steps.

You can have Elixir running quickly. We've recently added the deploy feature, which I think it's going to be nice to, so you can deploy a notebook as an application and I think, I think that's a nice way to give people Victories they can have along the way. So now they can say, Hey, I deployed this application.

And when they do that, when they deploy the application, they can share it with somebody, right? And then they can show somebody this thing that they built. And that's the general thought. But of course, like it's not only for learning, right?

Because, I think a lot of the DBG pipeline, like inspecting supervision, trees, those are all like, Very handful features for experience developers as well. And I also see like the deploy of applications being very useful for experience teams as well. Like, Hey, you know, you need to do something quickly that runs an Elixir script that needs to ping this, do that, right?

You could try to create the whole like admin interface for that. You could try to do X, Y, and Z, but with, Livebook, , you can write the notebook, you can get rid of these Crips and so on. Just write the notebook, deploy that as an application. And, we are working on ways so that can run inside your infrastructure and, now you have a deployed app, as a notebook.

So, yeah, so I, I think a lot of the times I think about really thinking about the learning experience first, which goes along the developer experience. And then we're trying to find ways of building even more on, on top of those building blocks.

Owen: This is music to my ears. I think, you know, each of us here is a fairly senior level developer. Jose, you've probably got, , several years on both me and Sundi but, think for this episode in particular, I imagine it will be shared with a lot of kind of newcomers to Elixir who are trying to like get their bearings and, you know, Thinking of people who maybe Elixir is their first language.

You know, anytime you're starting to kind of scratch your itch of the coding stuff, there's so many different things you have to learn. Like you have to learn about the terminal. If you're not acclimated to that, you've gotta install an editor, you gotta do all these things before you can even start really learning and playing with the language.

So I think it's amazing that we have a tool here with Livebook that, like you said, you install this. You know, binary, you like, you installed Mac os, windows or, or whatever, and it's just there. You don't have to like even open the terminal to get to it, and then you can just start writing Elixir code right away and seeing some results and, and seeing it all in one place.

You don't have to switch between your editor and a browser or, and all this other stuff. So it's, it's really cool that we have a tool that is really equally beneficial to senior engineers who are like watching a running application and writing interactive docs, but also for newcomers who don't have anything else installed on their on their computer, they can just install this thing and start writing Elixir code. It's really cool.

José: Yeah. And, and I think going back to smart cells, that's why I think they're like a game changer because with a smart cell you can achieve a task, but all that a smart cell can do is to tell your notebook to run some code. And you can always access, you can always see the code that is being executed by the smart cell.

So when you tell livebook, run a machine learning model for me. You can get that code, you can see it, you can ask to, you can say, Hey, I want this smart cell to become a regular code cell. And then you can change it in any way you want. And again, it's like, it's great for the learning experience, but it's also Great. Even for experienced developers because, well, you know, machine learning is new for the elixir community, right? Like the intersection of people who know elixir and machine learning. That venn diagram, it has like, know, very little in common. So you know, you have elixir developers.

That they don't know machine learning, and then they need to learn it and they could go through the documentation, but now they can click a button and get started. And you have machine learning developers who may be interested in elixir, but they don't know quite right how to write elixir code, and now they can just click the smart cell and get that thing running as well.

Yeah, all those things, again, like all very exciting and, and the problems they're solving.

Sundi: We're excited. To see the future of that for sure. I'm personally curious to see how the community takes machine learning and how they move forward with it. And of course, I, I would love to talk about this all day, but I don't wanna take too much more of your time. So I did wanna go ahead and ask you a very fun hot take question before we move into to plugs. Do you think we will see Elixir version 2.0 in the next 10 years?

José: Oh, in the next 10 years, if, uh, I don't know, um, I don't know. So my, my ideal thing for Elixir, so we've been talking about this, we now in the podcast where, you know, if we need to change something in Elixir, we have historically been able to do that except for like a very, very minor thing.

So, in my mind, Elixir 2.0 is like, get everything that has been deprecated. And we removed it, which means that if you're running, let's say that Elixir 1.30, which is the version before 2.0, if you're running Elixir 1.30 and you run it without depracation warnings. Then it means that you can now upgrade Elixir 2.0 and nothing is going to break.

That's how, in my mind, that's where I would, I would want to be. Uh, one of the things that may happen, and, and that's why like maybe, maybe 10 years is probably not enough, is that. If we do have a type system in elixir, once again, we want to introduce a type system in elixir , without breaking anything.

I don't think we're going to say, Hey, is any type system is Elixir 2.0, we break a bunch of stuff, deal with it. That's likely not we are doing, we are going to introduce it very gradually. So I have this one, which. May actually. I have this one, which is like, because what we're introducing is a gradual type system because it's the interface between static code and dynamic code.

So we say that those type systems, they are gradual because you can take dynamic code and gradually make them static, but we are also implementing a gradual type system gradually. So I say joking that it's a gradual, gradual type system. But, well we always talk about types later in another episode.

Everybody hated the name of that, but I think I, I mentioned that so many times that, we maybe stuck with it. But anyway, when we introduced like this gradual type system, gradually, it may be that we'll find out things like, hey, you know, like this api actually, you know, it would be more expressive.

wrote it like slightly different, or something like that. So those things may happen and then we may introduce more deprecations here and there. But again, the goal is always to ideally we, we, if we have to deprecate something, we will continue deprecating things. And when it's, when it's 2.0, it's just a matter, oh, we have so much legacy now, in the Elixir code base, I dunno, 10%, uh, 15% Elixir code base deprecations that it makes sense to, to do a clean break.

But it may be that we just say like, Hey, you know, it's fine. Um, we, we don't have to do the clean break. Yeah, we have those deprecations code, but this deprecated code. But you know, compared to everything that Elixir has, It's 10%. What is 10%? It's nothing. Right? Yeah, it's like 50 kilobytes in disc or whatever, right?

It doesn't matter. That's too small to matter to justify pushing change to users. So yeah, I think we are more on, on the side of, if had to guess right now, it would be, would be a no. It feels like 10 years is early, but maybe not. Yeah, but more like a no. Yes.

Sundi: I didn't actually know that we would get a yes or no answer, so woo-hoo! Thank you!

Owen: Yeah. So, before we wrap up here, just real quick side tangent. When you were demonstrating live book and doing the live transcription or close to realtime transcription, you, uh, used Hello Darkness, my old friend. I'm curious, I just pulled up the lyrics for that song. Is your preferred version the Disturbed &quot;Sound of Silence&quot; or the Simon and Garfunkel version.

José: I think I would go with the Simon one. They're both really good, but I, yeah, for some reason, I think the classical one. Yeah.

Owen: It's funny, Google. Google says The Sound of silence, A song by disturbed, which think is hilarious. But it just like that little mention caught me off guard.

José: One may even say it's a bit disturbing

Owen: It's, it's disturbing how Google got that so wrong. Cool. So, you know, yes. We'll be hearing from you again later this season about types with some of the folks we've been working on the typing system

for today's episode, do you have any final plugs or like if people want to get involved with Elixir or any of the many elixir ecosystem packages that, that you have kicking around the hex ecosystem, do you have any recommendations for folks?

José: No recommendations in particular. I think, usually the, well the community is very welcoming, so if you want to contribute to have ideas, whatever project is, I'm sure you can reach out to the maintainers or reach out in the Elixir Forum and get something started. So if you have any ideas, then a hundred percent go ahead and be in touch.

Owen: Right. I'll say this. Sometimes you open a PR on a project that you don't even think, oh, this isn't José's project, and then you get a little José comment or some, uh, rainbow emojis. It's always a nice little surprise. So thank you, Jose, Jose for joining us today. It's been so much fun and we will talk to you later on the season.

José: Yeah. See you later. Thanks for having me. Bye.

Intro/Outro: Elixir Wizards is a production of Smart Logic. You can find us online@smartlogic.io and we're at Smart Logic on Twitter. Don't forget to like, subscribe, and leave a review. This episode was produced and edited by Paloma Pechenik for Smart Logic. We'll see you next week for more on the next 10 years of Elixir.

Yair: Hey, this is Yair Flicker, president of SmartLogic, the company that brings you this podcast. SmartLogic is a consulting company that helps our clients accelerate the pace of their product development. We build custom software applications for our clients, typically using Phoenix and Elixir, Rails, React, and Flutter for mobile app development.

We're always happy to get acquainted even if there isn't an immediate need or opportunity. And, of course, referrals are always greatly appreciated. Please email contact@smartlogic.io to chat. Thanks, and have a great day!











