defmodule TomeStats.Api.SearchKeyController do
  use TomeStats.Web, :controller
  alias TomeStats.SearchKey

  def index(conn, _params) do
    search_keys = Repo.all(SearchKey)
    json conn, %{search_keys: search_keys}
  end
end
