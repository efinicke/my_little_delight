defmodule MyLittleDelight do
  use Application

  # Cette fonction est appelée lors du démarrage de l'application
  def start(_type, _args) do
    IO.puts("Démarrage de l'application MyLittleDelight")

    # Démarrer le cache avec Cachex
    children = [
      {MyLittleDelight.Cache, []}
    ]

    opts = [strategy: :one_for_one, name: MyLittleDelight.Supervisor]

    # Lancer le superviseur
    case Supervisor.start_link(children, opts) do
      {:ok, pid} ->  # Utilisation correcte de la variable pid
        {:ok, pid}  # Retourne le bon format que le superviseur attend

      {:error, reason} ->
        IO.puts("Erreur lors du démarrage de l'application: #{inspect(reason)}")  # Affiche l'erreur
        {:error, reason}  # Retourne l'erreur attendue
    end
  end
end
