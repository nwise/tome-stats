require IEx
defmodule TomeStats.SearchController do
  use TomeStats.Web, :controller

  def index(conn, _params) do
    render conn, "index.html", results: [] , search_url: ''
  end

  def create(conn, %{"search" => search_params}) do
    search_url = search_params
                 |> construct_search_uri(conn)

    render conn, "index.html", results: search_results(search_url), search_url: search_url
  end

  defp search_results(search_url) do
    HTTPotion.get(search_url).body \
    |> Poison.decode!
  end

  defp construct_search_uri(search_params, conn) do
    search_url = search_params
      |> convert_params
      |> concat_query_with_base
  end

  defp convert_params(search_params) do
    search_params
    |> Enum.reject(fn({k,v}) -> String.length(v) <= 0 end )
    |> Enum.map(fn({k,v}) -> (k <> "=" <> v) end )
    |> Enum.join("&")
  end

  defp concat_query_with_base(query_string) do
    URI.encode("http://zigur.te4.org/138884/afa509da-7308-4de5-a378-5c1750850def/characters/find?" <> query_string)
  end

  plug :load_search_keys when action in [:index, :create]
  defp load_search_keys(conn, _) do
    categories =
      Repo.all from(c in TomeStats.SearchKey,
                    order_by: c.name,
                    preload: [:search_key_values])
    assign(conn, :categories, categories)
  end
end
