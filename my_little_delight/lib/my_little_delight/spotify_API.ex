defmodule MyLittleDelight.SpotifyAPI do
  alias HTTPoison
  alias Jason
  alias MyLittleDelight.SpotifyAuth

  @oreslan_id "4FpJcNgOvIpSBeJgRg3OfN"  # ID d'Orelsan

  # Fonction pour récupérer la liste des albums d'Orelsan, seulement les noms
  def list_albums do
    case SpotifyAuth.get_access_token() do
      {:ok, token} ->
        get_oreslan_albums(token)
        |> Enum.map(& &1["name"])  # Extraire uniquement les noms des albums
        |> IO.inspect(label: "Albums d'Orelsan")  # Afficher pour debug
      {:error, reason} ->
        IO.puts("Erreur lors de la récupération du token: #{inspect(reason)}")
        {:error, reason}
    end
  end

  # Fonction pour récupérer les noms des albums d'Orelsan, en excluant les singles
  def list_albums_without_singles do
    case SpotifyAuth.get_access_token() do
      {:ok, token} ->
        albums = get_oreslan_albums(token)
        albums
        |> Enum.filter(fn album -> album["album_group"] != "single" end)  # Filtrage des singles
        |> Enum.map(& &1["name"])  # Extraire les noms des albums
        |> IO.inspect(label: "Albums sans singles")
      {:error, reason} ->
        IO.puts("Erreur lors de l'obtention du token: #{inspect(reason)}")
        {:error, reason}
    end
  end

  # Fonction pour récupérer les noms des albums d'Orelsan triés par date, du plus récent au plus ancien
  def list_albums_sorted_by_date do
    case SpotifyAuth.get_access_token() do
      {:ok, token} ->
        get_oreslan_albums(token)
        |> Enum.sort_by(& &1["release_date"], :desc)  # Trier par date de parution, du plus récent au plus ancien
        |> Enum.map(& &1["name"])  # Extraire les noms des albums
        |> IO.inspect(label: "Albums triés par date")  # Afficher pour debug
      {:error, reason} ->
        IO.puts("Erreur lors de la récupération du token: #{inspect(reason)}")
        {:error, reason}
    end
  end

  # Fonction privée pour récupérer les albums d'Orelsan via l'API
  defp get_oreslan_albums(token) do
    url = "https://api.spotify.com/v1/artists/#{@oreslan_id}/albums?limit=50"
    headers = [{"Authorization", "Bearer #{token}"}]

    case HTTPoison.get(url, headers) do
      {:ok, %{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, %{"items" => albums}} ->
            albums  # Retourne la liste d'albums brute
          {:error, _} ->
            IO.puts("Erreur lors du décodage de la réponse JSON")
            []
        end
      {:ok, %{status_code: status}} ->
        IO.puts("Erreur de l'API Spotify: statut #{status}")
        []
      {:error, reason} ->
        IO.puts("Erreur de connexion à l'API Spotify: #{inspect(reason)}")
        []
    end
  end
end
