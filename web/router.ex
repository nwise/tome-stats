defmodule TomeStats.Router do
  use TomeStats.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", TomeStats do
    pipe_through :browser # Use the default browser stack
    resources "search", SearchController, only: [:index, :create]
    resources "/search-keys", SearchKeyController
    resources "/search-key-values", SearchKeyValueController

    get "/", SearchController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api", TomeStats.Api do
    pipe_through :api
    resources "/search-keys", SearchKeyController
    resources "/search-key-values", SearchKeyValueController
  end
end
