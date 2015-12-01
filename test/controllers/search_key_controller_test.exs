defmodule TomeStats.SearchKeyControllerTest do
  use TomeStats.ConnCase

  alias TomeStats.SearchKey
  @valid_attrs %{category: "some content", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, search_key_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing search keys"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, search_key_path(conn, :new)
    assert html_response(conn, 200) =~ "New search key"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, search_key_path(conn, :create), search_key: @valid_attrs
    assert redirected_to(conn) == search_key_path(conn, :index)
    assert Repo.get_by(SearchKey, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, search_key_path(conn, :create), search_key: @invalid_attrs
    assert html_response(conn, 200) =~ "New search key"
  end

  test "shows chosen resource", %{conn: conn} do
    search_key = Repo.insert! %SearchKey{}
    conn = get conn, search_key_path(conn, :show, search_key)
    assert html_response(conn, 200) =~ "Show search key"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, search_key_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    search_key = Repo.insert! %SearchKey{}
    conn = get conn, search_key_path(conn, :edit, search_key)
    assert html_response(conn, 200) =~ "Edit search key"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    search_key = Repo.insert! %SearchKey{}
    conn = put conn, search_key_path(conn, :update, search_key), search_key: @valid_attrs
    assert redirected_to(conn) == search_key_path(conn, :show, search_key)
    assert Repo.get_by(SearchKey, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    search_key = Repo.insert! %SearchKey{}
    conn = put conn, search_key_path(conn, :update, search_key), search_key: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit search key"
  end

  test "deletes chosen resource", %{conn: conn} do
    search_key = Repo.insert! %SearchKey{}
    conn = delete conn, search_key_path(conn, :delete, search_key)
    assert redirected_to(conn) == search_key_path(conn, :index)
    refute Repo.get(SearchKey, search_key.id)
  end
end
