
# Charger les variables d'environnement dès le début
Dotenv.load()


defmodule MyLittleDelight do


  
 @moduledoc """
  Documentation for `MyLittleDelight`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> MyLittleDelight.hello()
      :world

  """
  def hello do
    :world
  end


  @doc """
  Test function to verify the setup.

  ## Examples

      iex> MyLittleDelight.hello_test()
      "Hello, Elixir!"
  """
  def hello_test do
    "Hello, Elixir!"
  end
end
