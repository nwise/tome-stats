defmodule TomeStats.PageController do
  use TomeStats.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
