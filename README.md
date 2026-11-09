# Gimme

```elixir
Gimme.dat(%{"key" => 1}, :key)
#=> {:ok, 1}

Gimme.dat(%{key: false}, "key")
#=> {:ok, false}

Gimme.dat(%{}, :key)
#=> {:error, :not_found}

Gimme.dat!(%{"key" => 1}, :key)
#=> 1

Gimme.dat!(%{}, :key)
#=> ** (KeyError)
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `gimme` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gimme, "~> 1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/gimme>.

