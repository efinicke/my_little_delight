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










