defmodule TomeStats.SearchKeyValueControllerTest do
  use TomeStats.ConnCase

  alias TomeStats.SearchKeyValue
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, search_key_value_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing search key values"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, search_key_value_path(conn, :new)
    assert html_response(conn, 200) =~ "New search key value"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, search_key_value_path(conn, :create), search_key_value: @valid_attrs
    assert redirected_to(conn) == search_key_value_path(conn, :index)
    assert Repo.get_by(SearchKeyValue, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, search_key_value_path(conn, :create), search_key_value: @invalid_attrs
    assert html_response(conn, 200) =~ "New search key value"
  end

  test "shows chosen resource", %{conn: conn} do
    search_key_value = Repo.insert! %SearchKeyValue{}
    conn = get conn, search_key_value_path(conn, :show, search_key_value)
    assert html_response(conn, 200) =~ "Show search key value"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, search_key_value_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    search_key_value = Repo.insert! %SearchKeyValue{}
    conn = get conn, search_key_value_path(conn, :edit, search_key_value)
    assert html_response(conn, 200) =~ "Edit search key value"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    search_key_value = Repo.insert! %SearchKeyValue{}
    conn = put conn, search_key_value_path(conn, :update, search_key_value), search_key_value: @valid_attrs
    assert redirected_to(conn) == search_key_value_path(conn, :show, search_key_value)
    assert Repo.get_by(SearchKeyValue, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    search_key_value = Repo.insert! %SearchKeyValue{}
    conn = put conn, search_key_value_path(conn, :update, search_key_value), search_key_value: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit search key value"
  end

  test "deletes chosen resource", %{conn: conn} do
    search_key_value = Repo.insert! %SearchKeyValue{}
    conn = delete conn, search_key_value_path(conn, :delete, search_key_value)
    assert redirected_to(conn) == search_key_value_path(conn, :index)
    refute Repo.get(SearchKeyValue, search_key_value.id)
  end
end
