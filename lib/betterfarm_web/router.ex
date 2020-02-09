defmodule BetterfarmWeb.Router do
  use BetterfarmWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BetterfarmWeb.Auth
    plug BetterfarmWeb.FetchCart
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BetterfarmWeb do
    pipe_through :browser

    get "/", PageController, :index
    post "/cart", CartController, :add
    get "/cart", CartController, :show
    resources "/market", MarketController

    resources "/farmers", FarmerController do
      resources "/products", ProductController
      resources "/video", VideoController
    end

    resources "/sessions", SessionController, only: [:new, :create, :delete]
    get "/watch/:id", WatchController, :show
  end

  # Other scopes may use custom stacks.
  # scope "/api", BetterfarmWeb do
  #   pipe_through :api
  # end
end
