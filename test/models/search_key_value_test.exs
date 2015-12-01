defmodule TomeStats.SearchKeyValueTest do
  use TomeStats.ModelCase

  alias TomeStats.SearchKeyValue

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SearchKeyValue.changeset(%SearchKeyValue{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SearchKeyValue.changeset(%SearchKeyValue{}, @invalid_attrs)
    refute changeset.valid?
  end
end
