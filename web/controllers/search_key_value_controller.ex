defmodule TomeStats.SearchKeyValueController do
  use TomeStats.Web, :controller
  alias TomeStats.SearchKeyValue

  plug :scrub_params, "search_key_value" when action in [:create, :update]

  def index(conn, _params) do
    search_key_values = Repo.all(SearchKeyValue)
    render(conn, "index.html", search_key_values: search_key_values)
  end

  def new(conn, _params) do
    changeset = SearchKeyValue.changeset(%SearchKeyValue{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"search_key_value" => search_key_value_params}) do
    changeset = SearchKeyValue.changeset(%SearchKeyValue{}, search_key_value_params)

    case Repo.insert(changeset) do
      {:ok, _search_key_value} ->
        conn
        |> put_flash(:info, "Search key value created successfully.")
        |> redirect(to: search_key_value_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    search_key_value = Repo.get!(SearchKeyValue, id)
    render(conn, "show.html", search_key_value: search_key_value)
  end

  def edit(conn, %{"id" => id}) do
    search_key_value = Repo.get!(SearchKeyValue, id)
    changeset = SearchKeyValue.changeset(search_key_value)
    render(conn, "edit.html", search_key_value: search_key_value, changeset: changeset)
  end

  def update(conn, %{"id" => id, "search_key_value" => search_key_value_params}) do
    search_key_value = Repo.get!(SearchKeyValue, id)
    changeset = SearchKeyValue.changeset(search_key_value, search_key_value_params)

    case Repo.update(changeset) do
      {:ok, search_key_value} ->
        conn
        |> put_flash(:info, "Search key value updated successfully.")
        |> redirect(to: search_key_value_path(conn, :show, search_key_value))
      {:error, changeset} ->
        render(conn, "edit.html", search_key_value: search_key_value, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    search_key_value = Repo.get!(SearchKeyValue, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(search_key_value)

    conn
    |> put_flash(:info, "Search key value deleted successfully.")
    |> redirect(to: search_key_value_path(conn, :index))
  end
end
