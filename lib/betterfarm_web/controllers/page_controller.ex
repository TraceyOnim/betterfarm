defmodule BetterfarmWeb.PageController do
  use BetterfarmWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
