defmodule MyLittleDelight.SpotifyAuth do
  @moduledoc """
  Module pour gérer l'authentification avec l'API Spotify.
  """

  # Fonction pour obtenir un access token de Spotify
  def get_access_token(client_id, client_secret, redirect_uri) do
    # L'URL d'authentification de Spotify
    url = "https://accounts.spotify.com/api/token"

    # Paramètres pour la requête
    body = URI.encode_query(%{
      "grant_type" => "client_credentials"
    })

    # Créer l'en-tête d'authentification en Base64
    auth_header = Base.encode64("#{client_id}:#{client_secret}")

    # Effectuer la requête HTTP POST pour récupérer le token
    headers = [
      {"Authorization", "Basic #{auth_header}"},
      {"Content-Type", "application/x-www-form-urlencoded"}
    ]

    # Effectuer la requête HTTP
    case HTTPoison.post(url, body, headers) do
      {:ok, response} ->
        # Si la requête réussie, extraire l'access token du JSON
        case Jason.decode(response.body) do
          {:ok, %{"access_token" => token}} ->
            {:ok, token}

          _ ->
            {:error, "Erreur lors de la récupération du token"}
        end

      {:error, _reason} ->
        {:error, "Erreur lors de la requête"}
    end
  end
end
