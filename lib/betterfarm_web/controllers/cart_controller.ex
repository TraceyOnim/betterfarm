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
    cart_changeset = Sales.change_cart(cart) |> IO.inspect()
    render(conn, "show.html", cart: cart, cart_changeset: cart_changeset)
  end

  def update(conn, %{"order" => cart_params}) do
    cart = conn.assigns.cart

    case Sales.update_cart(cart, cart_params) do
      {:ok, _cart} ->
        conn
        |> put_flash(:info, "Cart updated successfully")
        |> redirect(to: Routes.cart_path(conn, :show))

      {:error, _} ->
        conn
        |> put_flash(:error, "Error updating cart")
        |> redirect(to: Routes.cart_path(conn, :show))
    end
  end
end
