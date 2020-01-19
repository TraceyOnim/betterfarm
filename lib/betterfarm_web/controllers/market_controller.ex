defmodule BetterfarmWeb.MarketController do
  use BetterfarmWeb, :controller

  alias Betterfarm.Product.Catalog

  def index(conn, _params) do
    products = Catalog.list_product()
    render(conn, "index.html", products: products)
  end
end
