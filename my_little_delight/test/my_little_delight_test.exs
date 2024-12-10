defmodule MyLittleDelightTest do
  use ExUnit.Case
  doctest MyLittleDelight

  test "greets the world" do
    assert MyLittleDelight.hello() == :world
  end
end
