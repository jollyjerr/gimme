defmodule GimmeTest do
  use ExUnit.Case
  use ExUnitProperties
  doctest Gimme

  test "it works" do
    for key <- ["key", :key], map <- [%{key: true}, %{"key" => true}] do
      assert Gimme.dat(map, key) == {:ok, true}
      assert Gimme.dat!(map, key) == true
    end
  end

  test "false and nil count" do
    for value <- [false, nil], map <- [%{key: value}, %{"key" => value}], key <- [:key, "key"] do
      assert Gimme.dat(map, key) == {:ok, value}
      assert Gimme.dat!(map, key) == value
    end
  end

  test "should find nil, true, and false as keys" do
    for atom <- [nil, true, false], name = Atom.to_string(atom) do
      for map <- [%{atom => 1}, %{name => 1}], key <- [atom, name] do
        assert Gimme.dat(map, key) == {:ok, 1}
        assert Gimme.dat!(map, key) == 1
      end
    end
  end

  test "only maps, and only string or atom keys" do
    for {thing, key} <- [{[key: 1], :key}, {%{1 => :a}, 1}] do
      assert_raise FunctionClauseError, fn -> Gimme.dat(thing, key) end
    end
  end

  test "exact match wins for atoms too" do
    assert Gimme.dat(%{:key => 1, "key" => 2}, :key) == {:ok, 1}
  end

  property "it finds it no matter how it's stored" do
    check all(
            name <- key_name(),
            value <- term(),
            stored_as <- member_of([:atom, :string]),
            lookup_as <- member_of([:atom, :string])
          ) do
      atom = String.to_atom(name)
      map = if stored_as == :atom, do: %{atom => value}, else: %{name => value}
      key = if lookup_as == :atom, do: atom, else: name

      assert Gimme.dat(map, key) == {:ok, value}
      assert Gimme.dat!(map, key) == value
    end
  end

  property "it doesn't blow up when it's not there" do
    check all(
            name <- key_name(),
            lookup_as <- member_of([:atom, :string]),
            others <- map_of(one_of([string(:alphanumeric), atom(:alphanumeric)]), term())
          ) do
      key = if lookup_as == :atom, do: String.to_atom(name), else: name
      map = Map.reject(others, fn {k, _} -> to_string(k) == name end)

      assert Gimme.dat(map, key) == {:error, :not_found}
      assert_raise KeyError, fn -> Gimme.dat!(map, key) end
    end
  end

  defp key_name do
    string(:alphanumeric, min_length: 1)
  end
end
