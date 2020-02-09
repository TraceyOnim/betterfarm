defmodule BetterfarmWeb.CartView do
  use BetterfarmWeb, :view

  alias Betterfarm.Product.Catalog
  alias Betterfarm.Order

  def product_name(name) do
    Catalog.get_product_name(name)
  end

  def cart_count(conn = %Plug.Conn{}) do
    cart_count(conn.assigns.cart)
  end

  def cart_count(cart = %Order{}) do
    Enum.reduce(cart.line_items, 0, fn item, acc -> acc + item.quantity end)
  end
end
