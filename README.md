
  test "list_albums_without_singles: retourner liste des noms d'albums d'Oreslan sans singles" do
    {:ok, albums_without_singles} = SpotifyAPI.list_albums_without_singles()
    assert is_list(albums_without_singles)
    assert Enum.all?(albums_without_singles, fn album -> not String.contains?(album, "Single") end)
  end

  test "list_albums_sorted_by_date: retourner liste des noms d'albums d'Oreslan triée par date" do
    {:ok, albums_sorted} = SpotifyAPI.list_albums_sorted_by_date()
    assert is_list(albums_sorted)

    # Vérifier que les albums sont bien triés du plus récent au plus ancien
    assert Enum.sort(albums_sorted, &compare_dates/2) == albums_sorted
  end

  # Fonction auxiliaire pour comparer les albums en fonction de leurs dates
  defp compare_dates(album1, album2) do
    # On suppose que chaque album a une clé "release_date" formatée de manière correcte
    release_date1 = album1["release_date"]
    release_date2 = album2["release_date"]

    release_date1 >= release_date2  # On veut un tri décroissant
  end
end