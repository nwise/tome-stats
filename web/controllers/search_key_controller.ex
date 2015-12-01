defmodule TomeStats.SearchKeyController do
  use TomeStats.Web, :controller

  alias TomeStats.SearchKey

  plug :scrub_params, "search_key" when action in [:create, :update]

  def index(conn, _params) do
    search_keys = Repo.all(SearchKey)
    render(conn, "index.html", search_keys: search_keys)
  end

  def new(conn, _params) do
    changeset = SearchKey.changeset(%SearchKey{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"search_key" => search_key_params}) do
    changeset = SearchKey.changeset(%SearchKey{}, search_key_params)

    case Repo.insert(changeset) do
      {:ok, _search_key} ->
        conn
        |> put_flash(:info, "Search key created successfully.")
        |> redirect(to: search_key_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    search_key = Repo.get!(SearchKey, id)
    render(conn, "show.html", search_key: search_key)
  end

  def edit(conn, %{"id" => id}) do
    search_key = Repo.get!(SearchKey, id)
    changeset = SearchKey.changeset(search_key)
    render(conn, "edit.html", search_key: search_key, changeset: changeset)
  end

  def update(conn, %{"id" => id, "search_key" => search_key_params}) do
    search_key = Repo.get!(SearchKey, id)
    changeset = SearchKey.changeset(search_key, search_key_params)

    case Repo.update(changeset) do
      {:ok, search_key} ->
        conn
        |> put_flash(:info, "Search key updated successfully.")
        |> redirect(to: search_key_path(conn, :show, search_key))
      {:error, changeset} ->
        render(conn, "edit.html", search_key: search_key, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    search_key = Repo.get!(SearchKey, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(search_key)

    conn
    |> put_flash(:info, "Search key deleted successfully.")
    |> redirect(to: search_key_path(conn, :index))
  end
end
