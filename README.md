# Gimme

```elixir
Enum.each(["key", :key], fn key ->
  Enum.each([%{key: true}, %{"key" => true}], fn map ->
    assert Gimme.dat(map, key)
  end)
end)
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `gimme` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:gimme, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/gimme>.

