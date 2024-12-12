defmodule MyLittleDelight.SpotifyAuth do
  alias Cachex

  @cache_name :spotify_cache

  # Récupérer le token d'accès depuis le cache ou le générer s'il est absent ou expiré
  def get_access_token do
    case Cachex.get(@cache_name, :access_token) do
      {:ok, nil} ->
        IO.puts("Token non trouvé dans le cache, génération d'un nouveau token.")
        fetch_and_store_token()
      {:ok, token} ->
        IO.puts("Token trouvé dans le cache.")
        {:ok, token}
      {:error, reason} ->
        IO.inspect(reason, label: "Erreur du cache")
        fetch_and_store_token()
    end
  end

  # Récupérer la durée de validité restante du token dans le cache, en secondes
  def get_token_expiry do
    case Cachex.ttl(@cache_name, :access_token) do
      {:ok, nil} ->
        {:error, "Aucun token n'est actuellement stocké."}
      {:ok, ttl_ms} ->
        ttl_seconds = div(ttl_ms, 1000) # Convertir millisecondes en secondes
        IO.puts("Durée de validité du token : #{ttl_seconds} secondes")
        {:ok, ttl_seconds}
      {:error, reason} ->
        {:error, "Erreur lors de la récupération de la durée de validité: #{inspect(reason)}"}
    end
  end

  # Fonction privée pour récupérer un nouveau token et le stocker dans le cache
  defp fetch_and_store_token do
    client_id = System.get_env("SPOTIFY_CLIENT_ID") |> String.trim()
    client_secret = System.get_env("SPOTIFY_CLIENT_SECRET") |> String.trim()

    if client_id == "" or client_secret == "" do
      {:error, "Variables d'environnement manquantes"}
    else
      url = "https://accounts.spotify.com/api/token"
      body = URI.encode_query(%{ "grant_type" => "client_credentials" })
      auth_header = Base.encode64("#{client_id}:#{client_secret}")

      headers = [
        {"Authorization", "Basic #{auth_header}"},
        {"Content-Type", "application/x-www-form-urlencoded"}
      ]

      case HTTPoison.post(url, body, headers) do
        {:ok, %{status_code: 200, body: body}} ->
          case Jason.decode(body) do
            {:ok, %{"access_token" => token, "expires_in" => expires_in}} ->
              adjusted_ttl = max(expires_in - 10, 0)
              Cachex.put(@cache_name, :access_token, token, ttl: :timer.seconds(adjusted_ttl))
              IO.puts("Durée de validité du token : #{adjusted_ttl} secondes")
              {:ok, token}

            _ ->
              {:error, "Erreur lors de la décodification de la réponse de l'API Spotify"}
          end

        {:ok, %{status_code: status}} ->
          {:error, "Erreur de l'API Spotify: statut #{status}"}

        {:error, reason} ->
          {:error, "Erreur de connexion à l'API Spotify: #{inspect(reason)}"}
      end
    end
  end
end
