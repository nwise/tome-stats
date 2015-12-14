defmodule TomeStats.Api.SearchKeyValueController do
  use TomeStats.Web, :controller
  alias TomeStats.SearchKeyValue

  def index(conn, _params) do
    search_key_values = Repo.all(SearchKeyValue)
    json conn, %{search_key_values: search_key_values}
  end
end

