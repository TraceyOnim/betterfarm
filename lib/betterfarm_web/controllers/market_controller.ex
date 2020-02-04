defmodule BetterfarmWeb.MarketController do
  use BetterfarmWeb, :controller

  alias Betterfarm.Product.Catalog

  def index(conn, _params) do
    products = Catalog.list_product()
    IO.inspect(products, label: "prrrrrrrrrrrrrrrrrrrrrr")
    render(conn, "index.html", products: products)
  end
end
