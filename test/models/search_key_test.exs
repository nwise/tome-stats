defmodule TomeStats.SearchKeyTest do
  use TomeStats.ModelCase

  alias TomeStats.SearchKey

  @valid_attrs %{category: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SearchKey.changeset(%SearchKey{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SearchKey.changeset(%SearchKey{}, @invalid_attrs)
    refute changeset.valid?
  end
end
