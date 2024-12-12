defmodule MyLittleDelight.SpotifyAPI do
  alias MyLittleDelight.SpotifyAuth
  alias HTTPoison

  # Fonction pour récupérer la liste des albums d'Orelsan
  def get_oreslan_albums do
    case SpotifyAuth.get_access_token() do
      {:ok, token} ->
        fetch_albums(token)

      {:error, reason} ->
        IO.puts("Erreur lors de la récupération du token d'accès: #{reason}")
        {:error, reason}
    end
  end

  # Fonction pour récupérer les albums en utilisant l'API Spotify
  defp fetch_albums(token) do
    artist_id = "4IcL6hPNC9z0e98vlxjmoV"  # ID Spotify d'Orelsan
    url = "https://api.spotify.com/v1/artists/#{artist_id}/albums?limit=50"  # Limite de 50 albums par requête

    headers = [
      {"Authorization", "Bearer #{token}"}
    ]

    case HTTPoison.get(url, headers) do
      {:ok, %{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, %{"items" => albums}} ->
            IO.puts("Albums d'Orelsan récupérés avec succès.")
            {:ok, albums}

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
