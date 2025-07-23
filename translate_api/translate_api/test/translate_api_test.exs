defmodule TranslateAPITest do
  use ExUnit.Case
  doctest TranslateAPI

  test "greets the world" do
    assert TranslateAPI.hello() == :world
  end
end
