defmodule MyLittleDelight.SpotifyAPI do
  alias HTTPoison
  alias Jason
  alias MyLittleDelight.SpotifyAuth


  @artist_id "4FpJcNgOvIpSBeJgRg3OfN"  # id d'Oreslan

# Récupérer la liste des noms d'albums d'un artiste
def list_albums do
  with {:ok, albums, _count} <- get_albums_by_artist() do
    albums_names = albums
                  |> Enum.map(& &1["name"])  # Extraire les noms des albums
    {:ok, albums_names}
  else
    {:error, reason} ->
      IO.puts("Erreur lors de la récupération des albums: #{inspect(reason)}")
      {:error, reason}
  end
end


  # Récupérer la liste des noms d'albums d'un artiste, excluant les singles
  def list_albums_without_singles do
    case get_albums_by_artist() do
      {:ok, albums, _count} ->
        albums_names = albums
                      |> Enum.filter(fn album -> album["album_group"] != "single" end)
                      |> Enum.map(& &1["name"])
        {:ok, albums_names}
      {:error, reason} ->
        IO.puts("Erreur lors de l'obtention des albums: #{inspect(reason)}")
        {:error, reason}
    end
  end

# Récupérer la liste des noms des albums d'un artiste, triés par date, du plus récent au plus ancien
def list_albums_sorted_by_date do
  case get_albums_by_artist() do
    {:ok, albums, _count} ->
      albums_names = albums
                    |> Enum.sort_by(& &1["release_date"], :desc)
                    |> Enum.map(& &1["name"])
      {:ok, albums_names}
    {:error, reason} ->
      IO.puts("Erreur lors de la récupération des albums: #{inspect(reason)}")
      {:error, reason}
  end
end


  # Récupérer la liste des albums d'un artiste avec leurs objets JSON complets
  def get_albums_by_artist do
    case SpotifyAuth.get_access_token() do
      {:ok, token} ->
        headers = [{"Authorization", "Bearer #{token}"}]
        case fetch_all_albums_iteratively(headers, 0, [], @artist_id) do
          {:ok, albums_json} ->
            album_count = length(albums_json)
            {:ok, albums_json, album_count}
          {:error, reason} ->
            {:error, reason}
        end
      {:error, reason} ->
        IO.puts("Erreur lors de la récupération du token: #{inspect(reason)}")
        {:error, reason}
    end
  end

  # Récupérer la liste des albums d'un artiste via l'API (objets JSON complets)
  defp fetch_all_albums_iteratively(headers, offset, all_albums_json, artist_id) do
    url = "https://api.spotify.com/v1/artists/#{artist_id}/albums?limit=50&offset=#{offset}"

    case HTTPoison.get(url, headers) do
      {:ok, %{status_code: 200, body: body}} ->
        case Jason.decode(body) do
          {:ok, %{"items" => albums, "total" => total}} ->
            new_all_albums_json = all_albums_json ++ albums
            if length(new_all_albums_json) >= total do
              {:ok, new_all_albums_json}
            else
              fetch_all_albums_iteratively(headers, offset + 50, new_all_albums_json, artist_id)
            end
          {:error, decode_error} ->
            IO.puts("Erreur lors du décodage de la réponse JSON: #{inspect(decode_error)}")
            {:error, all_albums_json}
        end
      {:ok, %{status_code: status}} ->
        IO.puts("Erreur de l'API Spotify: statut #{status}")
        {:error, all_albums_json}
      {:error, reason} ->
        IO.puts("Erreur de connexion à l'API Spotify: #{inspect(reason)}")
        {:error, all_albums_json}
    end
  end
end
