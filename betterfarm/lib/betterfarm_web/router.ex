defmodule BetterfarmWeb.Router do
  use BetterfarmWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BetterfarmWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BetterfarmWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/farmers", FarmerController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
    resources "/products", ProductController
  end

  # Other scopes may use custom stacks.
  # scope "/api", BetterfarmWeb do
  #   pipe_through :api
  # end
end
