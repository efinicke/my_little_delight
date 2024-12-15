defmodule MyLittleDelight.MixProject do
  use Mix.Project

  def project do
    [
      app: :my_little_delight,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Définir le module principal à démarrer
  def application do
    [
      extra_applications: [:logger],
      mod: {MyLittleDelight, []}  # Spécification du module principal
    ]
  end

  defp deps do
    [
      {:httpoison, "~> 1.8"},
      {:jason, "~> 1.2"},
      {:dotenv, "~> 3.0"},
      {:cachex, "~> 3.3"},
      {:mix_test_watch, "~> 1.1", only: :dev, runtime: false},
      {:mox, "~> 1.2.0", only: :test},
    ]
  end
end
