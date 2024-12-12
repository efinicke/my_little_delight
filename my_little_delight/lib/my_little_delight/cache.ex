defmodule MyLittleDelight.Cache do
  use GenServer

  # Fonction pour démarrer le cache avec Cachex
  def start_link(opts \\ []) do
    # Récupérer le nom du cache depuis les options, sinon utiliser la valeur par défaut
    cache_name = Keyword.get(opts, :cache_name, :spotify_cache)

    # Démarrer Cachex avec le nom du cache
    case Cachex.start_link(cache_name, []) do
      {:ok, pid} ->
        IO.puts("Cache #{cache_name} démarré avec succès")
        {:ok, pid}

      {:error, reason} ->
        IO.puts("Erreur lors du démarrage du cache #{cache_name}: #{inspect(reason)}")
        {:error, reason}
    end
  end

  # Callbacks du GenServer
  def init(_args) do
    IO.puts("Cache initialisé")  # Message affiché quand le cache est initialisé
    {:ok, %{}}
  end
end
