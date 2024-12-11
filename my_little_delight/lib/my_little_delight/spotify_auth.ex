defmodule MyLittleDelight.SpotifyAuth do
  @moduledoc """
  Module pour gérer l'authentification avec l'API Spotify.
  """

  # Fonction pour obtenir un access token de Spotify
  def get_access_token do
    client_id = System.get_env("SPOTIFY_CLIENT_ID") |> String.trim()
    client_secret = System.get_env("SPOTIFY_CLIENT_SECRET") |> String.trim()
    redirect_uri = System.get_env("SPOTIFY_REDIRECT_URI") |> String.trim()

    IO.inspect(client_id, label: "client_id")
    IO.inspect(client_secret, label: "client_secret")
    IO.inspect(redirect_uri, label: "redirect_uri")

    if client_id == "" or client_secret == "" or redirect_uri == "" do
      {:error, "Variables d'environnement manquantes"}
    else
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

      IO.inspect(headers, label: "Request headers")

      # Effectuer la requête HTTP
      case HTTPoison.post(url, body, headers) do
        {:ok, response} ->
          IO.inspect(response, label: "Response")
          case Jason.decode(response.body) do
            {:ok, %{"access_token" => token}} ->
              {:ok, token}

            _ ->
              {:error, "Erreur lors de la récupération du token"}
          end

        {:error, reason} ->
          IO.inspect(reason, label: "Request error")
          {:error, "Erreur lors de la requête"}
      end
    end
  end
end
