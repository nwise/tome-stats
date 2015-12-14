defmodule TomeStats.SearchController do
  use TomeStats.Web, :controller
  alias TomeStats.Search
  alias TomeStats.SearchKey

  def index(conn, _params) do
    conn
    |> assign(:search, %Search{})
    |> render "index.html"

  end

  def create(conn, %{"search" => search_params}) do
    conn
    |> assign(:search, Search.search(search_params))
    |> render "index.html"
  end

  plug :load_search_keys when action in [:index, :create]
  defp load_search_keys(conn, _) do
    categories =
      Repo.all from(c in SearchKey,
                    order_by: c.name,
                    preload: [:search_key_values])
    assign(conn, :categories, categories)
  end
end
