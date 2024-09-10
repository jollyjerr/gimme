defmodule Gimme do
  @moduledoc """
  Need to ship a feature but yo data is wack? Use `Gimme.dat(map, :key)`!
  """

  @doc """
  Get any `:key` or `"key"` from a map :)
  """
  @spec dat(map(), String.t() | atom()) :: any()
  def dat(thing, key),
    do: thing[key] || thing[to_string(key)] || thing[String.to_existing_atom(key)]
end
