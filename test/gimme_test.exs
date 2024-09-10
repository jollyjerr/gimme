defmodule GimmeTest do
  use ExUnit.Case
  doctest Gimme

  test "it works" do
    Enum.each(["key", :key], fn key ->
      Enum.each([%{key: true}, %{"key" => true}], fn map ->
        assert Gimme.dat(map, key)
      end)
    end)
  end
end
