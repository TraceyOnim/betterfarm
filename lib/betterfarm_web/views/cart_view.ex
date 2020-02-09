defmodule BetterfarmWeb.CartView do
  use BetterfarmWeb, :view

  alias Betterfarm.Product.Catalog

  def product_name(name) do
    Catalog.get_product_name(name)
  end
end
