defmodule BetterfarmWeb.CartController do
  use BetterfarmWeb, :controller

  alias Betterfarm.Sales

  def add(conn, %{"cart" => cart_params}) do
    cart = conn.assigns.cart

    case Sales.add_to_cart(cart, cart_params) do
      {:ok, _cart} ->
        conn
        |> put_flash(:info, "Added to cart successfully")
        |> redirect(to: Routes.market_path(conn, :index))

      {:error, changeset} ->
        conn
        |> put_flash(:error, "failed to add to cart")
        |> render("index.html", changeset: changeset)
    end
  end

  def show(conn, _param) do
    cart = conn.assigns.cart
    render(conn, "show.html", cart: cart)
  end
end
