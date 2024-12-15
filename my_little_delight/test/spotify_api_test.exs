defmodule MyLittleDelight.SpotifyAPITest do
  use ExUnit.Case

  # Fonction pour colorier le texte en fonction de la couleur choisie
  defp color_text(text, color) do
    colors = %{
      red: "\e[31m",
      green: "\e[32m",
      yellow: "\e[33m",
      blue: "\e[34m",
      magenta: "\e[35m",
      cyan: "\e[36m",
      reset: "\e[0m"
    }

    "#{colors[color]}#{text}#{colors[:reset]}"
  end

  # Test pour la fonction list_albums
  test "PART 1 : list_albums retourne une liste des noms des albums d'Oreslan" do
    IO.puts("\n" <> color_text("==> Test: list_albums", :cyan))

    case MyLittleDelight.SpotifyAPI.list_albums() do
      {:ok, albums_names} ->
        IO.puts("\n" <> color_text("Albums retournés:", :green))
        IO.inspect(albums_names)
        assert is_list(albums_names)

      {:error, reason} ->
        IO.puts("\n" <> color_text("Erreur retournée par list_albums:", :red))
        IO.inspect(reason)
        assert false
    end
  end

  # Test pour la fonction list_albums_without_singles
  test "PART 2 : list_albums_without_singles retourne une liste des noms d'albums d'Oreslan (sans singles)" do
    IO.puts("\n" <> color_text("==> Test: list_albums_without_singles", :cyan))

    case MyLittleDelight.SpotifyAPI.list_albums_without_singles() do
      {:ok, albums_names} ->
        IO.puts("\n" <> color_text("Albums (sans singles) retournés:", :green))
        IO.inspect(albums_names)
        assert is_list(albums_names)

      {:error, reason} ->
        IO.puts("\n" <> color_text("Erreur retournée par list_albums_without_singles:", :red))
        IO.inspect(reason)
        assert false
    end
  end

  # Test pour la fonction list_albums_sorted_by_date
  test "PART 3 : list_albums_sorted_by_date retourne une liste des noms d'albums d'Oreslan triés par date" do
    IO.puts("\n" <> color_text("==> Test: list_albums_sorted_by_date", :cyan))

    case MyLittleDelight.SpotifyAPI.list_albums_sorted_by_date() do
      {:ok, albums_names} ->
        IO.puts("\n" <> color_text("Albums triés par date retournés:", :green))
        IO.inspect(albums_names)
        assert is_list(albums_names)

      {:error, reason} ->
        IO.puts("\n" <> color_text("Erreur retournée par list_albums_sorted_by_date:", :red))
        IO.inspect(reason)
        assert false
    end
  end
end
