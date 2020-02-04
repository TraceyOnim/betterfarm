defmodule BetterfarmWeb.CartController do
  use BetterfarmWeb, :controller

  def add(conn, %{"cart" => attrs}) do
    cart = conn.assigns.cart
    IO.inspect(conn)
  end
end
